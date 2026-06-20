import Foundation

enum TriviaCategory: String, CaseIterable, Codable, Identifiable {
    case animals = "動物"
    case science = "科学"
    case history = "歴史"
    case food = "食べ物"
    case body = "人体"
    case space = "宇宙"
    case language = "言葉"
    case random = "雑学"

    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .animals: return "🐙"
        case .science: return "🔬"
        case .history: return "📜"
        case .food: return "🍯"
        case .body: return "🧠"
        case .space: return "🚀"
        case .language: return "📝"
        case .random: return "💡"
        }
    }
}

enum Difficulty: String, CaseIterable, Codable {
    case easy = "かんたん"
    case normal = "ふつう"
    case hard = "むずかしい"

    var timeLimit: TimeInterval {
        switch self {
        case .easy: return 60
        case .normal: return 40
        case .hard: return 25
        }
    }

    var roundCount: Int {
        switch self {
        case .easy: return 5
        case .normal: return 8
        case .hard: return 10
        }
    }
}

struct TriviaItem: Identifiable {
    let id = UUID()
    let category: TriviaCategory
    let displayText: String
    let explanation: String
    let difficulty: Difficulty
}

enum CharacterStatus {
    case pending
    case current
    case correct
    case incorrect
}

struct CharacterState: Identifiable {
    let id = UUID()
    let character: Character
    var status: CharacterStatus = .pending
}

struct RoundResult: Identifiable {
    let id = UUID()
    let trivia: TriviaItem
    let correctCount: Int
    let totalCount: Int
    let timeTaken: TimeInterval
    let maxStreak: Int

    var accuracy: Double {
        totalCount == 0 ? 0 : Double(correctCount) / Double(totalCount) * 100
    }

    var score: Int {
        let baseScore = correctCount * 10
        let speedBonus = Int(max(0, trivia.difficulty.timeLimit - timeTaken) * 5)
        let accuracyBonus = accuracy > 80 ? Int(accuracy * 2) : 0
        let streakBonus = (maxStreak / 5) * 15
        return baseScore + speedBonus + accuracyBonus + streakBonus
    }
}

enum GamePhase: Equatable {
    case menu
    case countdown(Int)
    case playing
    case roundResult
    case gameOver
}

enum Rank: String {
    case s = "S"
    case a = "A"
    case b = "B"
    case c = "C"
    case d = "D"

    var color: String {
        switch self {
        case .s: return "rankS"
        case .a: return "rankA"
        case .b: return "rankB"
        case .c: return "rankC"
        case .d: return "rankD"
        }
    }

    static func from(accuracy: Double, avgTime: Double) -> Rank {
        if accuracy >= 95 && avgTime < 15 { return .s }
        if accuracy >= 85 && avgTime < 25 { return .a }
        if accuracy >= 70 && avgTime < 35 { return .b }
        if accuracy >= 50 { return .c }
        return .d
    }
}
