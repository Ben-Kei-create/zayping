import SwiftUI

struct RoundResultView: View {
    @EnvironmentObject var game: GameManager
    @State private var showContent = false

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            if let result = game.roundResults.last {
                VStack(spacing: 20) {
                    Text("Round \(game.currentRound) 完了！")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(Color.theme.textPrimary)

                    VStack(spacing: 8) {
                        HStack(spacing: 4) {
                            Text(result.trivia.category.emoji)
                            Text(result.trivia.displayText)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color.theme.neonBlue)
                        }

                        Text(result.trivia.explanation)
                            .font(.system(size: 14))
                            .foregroundColor(Color.theme.textSecondary)
                            .multilineTextAlignment(.center)
                            .lineLimit(3)
                            .padding(.horizontal, 40)
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.theme.cardBackground)
                    )
                    .frame(maxWidth: 600)

                    HStack(spacing: 40) {
                        ResultStat(title: "正解率", value: String(format: "%.0f%%", result.accuracy),
                                   color: result.accuracy >= 80 ? Color.theme.correct : Color.theme.incorrect)
                        ResultStat(title: "タイム", value: String(format: "%.1f秒", result.timeTaken),
                                   color: Color.theme.neonBlue)
                        ResultStat(title: "スコア", value: "\(result.score)",
                                   color: Color.theme.neonYellow)
                        ResultStat(title: "最高コンボ", value: "\(result.maxStreak)",
                                   color: Color.theme.neonPink)
                    }
                }
                .opacity(showContent ? 1 : 0)
                .offset(y: showContent ? 0 : 20)
            }

            Spacer().frame(height: 20)

            Button {
                game.proceedAfterResult()
            } label: {
                HStack(spacing: 8) {
                    Text(game.currentRound >= game.totalRounds ? "結果を見る" : "次のラウンドへ")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .padding(.horizontal, 36)
                .padding(.vertical, 14)
                .background(
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [Color.theme.neonBlue, Color.theme.neonPurple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                )
            }
            .buttonStyle(.plain)
            .opacity(showContent ? 1 : 0)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            withAnimation(.easeOut(duration: 0.5).delay(0.2)) {
                showContent = true
            }
        }
        .onDisappear {
            showContent = false
        }
    }
}

struct ResultStat: View {
    let title: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: 6) {
            Text(value)
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(color)
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(Color.theme.textSecondary)
        }
    }
}
