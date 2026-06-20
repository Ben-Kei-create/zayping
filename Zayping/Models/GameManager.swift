import SwiftUI
import Combine

class GameManager: ObservableObject {
    @Published var phase: GamePhase = .menu
    @Published var difficulty: Difficulty = .normal
    @Published var currentRound: Int = 0
    @Published var totalRounds: Int = 8
    @Published var currentTrivia: TriviaItem?
    @Published var characters: [CharacterState] = []
    @Published var currentIndex: Int = 0
    @Published var timeRemaining: TimeInterval = 40
    @Published var score: Int = 0
    @Published var streak: Int = 0
    @Published var bestStreak: Int = 0
    @Published var roundResults: [RoundResult] = []
    @Published var inputText: String = ""
    @Published var shakeWrong: Bool = false
    @Published var showStreakEffect: Bool = false
    @Published var comboMessage: String = ""

    @AppStorage("highScore") var highScore: Int = 0

    private var timer: AnyCancellable?
    private var countdownTimer: AnyCancellable?
    private var triviaQueue: [TriviaItem] = []
    private var roundStartTime: Date = Date()
    private var roundCorrectCount: Int = 0
    private var roundTotalTyped: Int = 0

    func startGame(difficulty: Difficulty) {
        self.difficulty = difficulty
        self.totalRounds = difficulty.roundCount
        self.currentRound = 0
        self.score = 0
        self.roundResults = []
        self.bestStreak = 0

        triviaQueue = TriviaBank.randomItems(count: totalRounds, difficulty: difficulty)
        startNextRound()
    }

    func startNextRound() {
        currentRound += 1
        guard currentRound <= totalRounds, !triviaQueue.isEmpty else {
            endGame()
            return
        }

        let trivia = triviaQueue.removeFirst()
        currentTrivia = trivia
        characters = trivia.displayText.map { CharacterState(character: $0) }
        currentIndex = 0
        streak = 0
        roundCorrectCount = 0
        roundTotalTyped = 0
        inputText = ""

        if !characters.isEmpty {
            characters[0].status = .current
        }

        startCountdown()
    }

    private func startCountdown() {
        var count = 3
        phase = .countdown(count)

        countdownTimer?.cancel()
        countdownTimer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                count -= 1
                if count > 0 {
                    self.phase = .countdown(count)
                } else {
                    self.countdownTimer?.cancel()
                    self.phase = .playing
                    self.timeRemaining = self.difficulty.timeLimit
                    self.roundStartTime = Date()
                    self.startTimer()
                }
            }
    }

    private func startTimer() {
        timer?.cancel()
        timer = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                let elapsed = Date().timeIntervalSince(self.roundStartTime)
                self.timeRemaining = max(0, self.difficulty.timeLimit - elapsed)
                if self.timeRemaining <= 0 {
                    self.finishRound()
                }
            }
    }

    func processInput(_ newText: String) {
        guard phase == .playing else { return }
        guard newText.count > inputText.count else {
            inputText = newText
            return
        }

        let newChar = newText.last!
        guard currentIndex < characters.count else { return }

        let expected = characters[currentIndex].character
        roundTotalTyped += 1

        if newChar == expected {
            characters[currentIndex].status = .correct
            roundCorrectCount += 1
            streak += 1
            bestStreak = max(bestStreak, streak)

            if streak > 0 && streak % 5 == 0 {
                triggerStreakEffect()
            }

            let basePoints = 10
            let streakMultiplier = 1.0 + Double(streak) / 20.0
            score += Int(Double(basePoints) * streakMultiplier)

            currentIndex += 1
            if currentIndex < characters.count {
                characters[currentIndex].status = .current
            } else {
                finishRound()
                return
            }
        } else {
            characters[currentIndex].status = .incorrect
            streak = 0
            shakeWrong = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                guard let self = self else { return }
                self.shakeWrong = false
                if self.currentIndex < self.characters.count {
                    self.characters[self.currentIndex].status = .current
                }
            }
        }

        inputText = newText
    }

    private func triggerStreakEffect() {
        let messages = ["ナイス！", "すごい！", "最高！", "神！", "鬼タイピング！", "止まらない！"]
        let index = min((streak / 5) - 1, messages.count - 1)
        comboMessage = messages[index]
        showStreakEffect = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.showStreakEffect = false
        }
    }

    private func finishRound() {
        timer?.cancel()
        let timeTaken = Date().timeIntervalSince(roundStartTime)

        if let trivia = currentTrivia {
            let result = RoundResult(
                trivia: trivia,
                correctCount: roundCorrectCount,
                totalCount: roundTotalTyped,
                timeTaken: timeTaken,
                maxStreak: bestStreak
            )
            roundResults.append(result)
        }

        phase = .roundResult
    }

    func proceedAfterResult() {
        if currentRound >= totalRounds {
            endGame()
        } else {
            startNextRound()
        }
    }

    private func endGame() {
        timer?.cancel()
        if score > highScore {
            highScore = score
        }
        phase = .gameOver
    }

    func returnToMenu() {
        timer?.cancel()
        countdownTimer?.cancel()
        phase = .menu
        score = 0
        currentRound = 0
        roundResults = []
    }

    var totalAccuracy: Double {
        guard !roundResults.isEmpty else { return 0 }
        let total = roundResults.reduce(0.0) { $0 + $1.accuracy }
        return total / Double(roundResults.count)
    }

    var averageTime: Double {
        guard !roundResults.isEmpty else { return 0 }
        let total = roundResults.reduce(0.0) { $0 + $1.timeTaken }
        return total / Double(roundResults.count)
    }

    var finalRank: Rank {
        Rank.from(accuracy: totalAccuracy, avgTime: averageTime)
    }

    var totalScore: Int {
        roundResults.reduce(0) { $0 + $1.score }
    }
}
