import SwiftUI

struct HomeView: View {
    @EnvironmentObject var game: GameManager
    @State private var selectedDifficulty: Difficulty = .normal
    @State private var titleScale: CGFloat = 0.8
    @State private var titleOpacity: Double = 0
    @State private var buttonsOffset: CGFloat = 30
    @State private var buttonsOpacity: Double = 0

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            titleSection

            Spacer().frame(height: 50)

            difficultySection

            Spacer().frame(height: 30)

            startButton

            Spacer().frame(height: 20)

            highScoreSection

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.1)) {
                titleScale = 1.0
                titleOpacity = 1.0
            }
            withAnimation(.easeOut(duration: 0.5).delay(0.3)) {
                buttonsOffset = 0
                buttonsOpacity = 1.0
            }
        }
    }

    private var titleSection: some View {
        VStack(spacing: 12) {
            Text("ZAYPING")
                .font(.system(size: 56, weight: .black, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color.theme.neonBlue,
                            Color.theme.neonPurple,
                            Color.theme.neonPink
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .shadow(color: Color.theme.neonBlue.opacity(0.4), radius: 15)

            Text("雑学タイピングゲーム")
                .font(.system(size: 20, weight: .medium, design: .rounded))
                .foregroundColor(Color.theme.textSecondary)

            Text("おもしろ雑学をタイピングしよう！")
                .font(.system(size: 15))
                .foregroundColor(Color.theme.textSecondary.opacity(0.7))
        }
        .scaleEffect(titleScale)
        .opacity(titleOpacity)
    }

    private var difficultySection: some View {
        VStack(spacing: 12) {
            Text("難易度")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color.theme.textSecondary)

            HStack(spacing: 12) {
                ForEach(Difficulty.allCases, id: \.rawValue) { diff in
                    DifficultyButton(
                        difficulty: diff,
                        isSelected: selectedDifficulty == diff
                    ) {
                        withAnimation(.spring(response: 0.3)) {
                            selectedDifficulty = diff
                        }
                    }
                }
            }
        }
        .offset(y: buttonsOffset)
        .opacity(buttonsOpacity)
    }

    private var startButton: some View {
        Button {
            game.startGame(difficulty: selectedDifficulty)
        } label: {
            HStack(spacing: 10) {
                Image(systemName: "keyboard.fill")
                    .font(.system(size: 18))
                Text("ゲームスタート")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 40)
            .padding(.vertical, 16)
            .background(
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [Color.theme.neonBlue, Color.theme.neonPurple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .shadow(color: Color.theme.neonBlue.opacity(0.4), radius: 10)
            )
        }
        .buttonStyle(.plain)
        .offset(y: buttonsOffset)
        .opacity(buttonsOpacity)
    }

    private var highScoreSection: some View {
        Group {
            if game.highScore > 0 {
                HStack(spacing: 6) {
                    Image(systemName: "trophy.fill")
                        .foregroundColor(Color.theme.neonYellow)
                    Text("ハイスコア: \(game.highScore)")
                        .foregroundColor(Color.theme.textSecondary)
                }
                .font(.system(size: 14, weight: .medium))
                .opacity(buttonsOpacity)
            }
        }
    }
}

struct DifficultyButton: View {
    let difficulty: Difficulty
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text(difficulty.rawValue)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                Text("\(Int(difficulty.timeLimit))秒 × \(difficulty.roundCount)問")
                    .font(.system(size: 11))
                    .opacity(0.7)
            }
            .foregroundColor(isSelected ? .white : Color.theme.textSecondary)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color.theme.neonPurple.opacity(0.3) : Color.theme.cardBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? Color.theme.neonPurple : Color.clear, lineWidth: 2)
                    )
            )
        }
        .buttonStyle(.plain)
    }
}
