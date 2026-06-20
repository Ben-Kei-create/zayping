import SwiftUI

struct GameOverView: View {
    @EnvironmentObject var game: GameManager
    @State private var rankScale: CGFloat = 3.0
    @State private var rankOpacity: Double = 0
    @State private var showStats = false
    @State private var showButtons = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer().frame(height: 30)

                Text("ゲーム終了！")
                    .font(.system(size: 32, weight: .black, design: .rounded))
                    .foregroundColor(Color.theme.textPrimary)

                rankBadge

                Spacer().frame(height: 10)

                totalScoreSection
                    .opacity(showStats ? 1 : 0)
                    .offset(y: showStats ? 0 : 20)

                statsGrid
                    .opacity(showStats ? 1 : 0)
                    .offset(y: showStats ? 0 : 20)

                roundHistory
                    .opacity(showStats ? 1 : 0)

                Spacer().frame(height: 10)

                buttonSection
                    .opacity(showButtons ? 1 : 0)

                Spacer().frame(height: 30)
            }
            .frame(maxWidth: 700)
            .frame(maxWidth: .infinity)
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6).delay(0.3)) {
                rankScale = 1.0
                rankOpacity = 1.0
            }
            withAnimation(.easeOut(duration: 0.5).delay(0.8)) {
                showStats = true
            }
            withAnimation(.easeOut(duration: 0.3).delay(1.3)) {
                showButtons = true
            }
        }
    }

    private var rankBadge: some View {
        VStack(spacing: 8) {
            Text(game.finalRank.rawValue)
                .font(.system(size: 80, weight: .black, design: .rounded))
                .foregroundStyle(rankGradient)
                .shadow(color: rankShadowColor.opacity(0.5), radius: 20)
                .scaleEffect(rankScale)
                .opacity(rankOpacity)

            Text("ランク")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color.theme.textSecondary)
                .opacity(rankOpacity)
        }
    }

    private var rankGradient: LinearGradient {
        switch game.finalRank {
        case .s:
            return LinearGradient(colors: [Color.theme.neonYellow, Color.orange], startPoint: .top, endPoint: .bottom)
        case .a:
            return LinearGradient(colors: [Color.theme.neonPink, Color.theme.neonPurple], startPoint: .top, endPoint: .bottom)
        case .b:
            return LinearGradient(colors: [Color.theme.neonBlue, Color.theme.neonGreen], startPoint: .top, endPoint: .bottom)
        case .c:
            return LinearGradient(colors: [Color.theme.neonBlue, Color.theme.textSecondary], startPoint: .top, endPoint: .bottom)
        case .d:
            return LinearGradient(colors: [Color.theme.textSecondary, Color.theme.pending], startPoint: .top, endPoint: .bottom)
        }
    }

    private var rankShadowColor: Color {
        switch game.finalRank {
        case .s: return Color.theme.neonYellow
        case .a: return Color.theme.neonPink
        case .b: return Color.theme.neonBlue
        case .c, .d: return Color.theme.textSecondary
        }
    }

    private var totalScoreSection: some View {
        VStack(spacing: 4) {
            Text("\(game.totalScore)")
                .font(.system(size: 48, weight: .black, design: .monospaced))
                .foregroundColor(Color.theme.neonYellow)
            Text("トータルスコア")
                .font(.system(size: 14))
                .foregroundColor(Color.theme.textSecondary)

            if game.totalScore >= game.highScore && game.totalScore > 0 {
                Text("NEW HIGH SCORE!")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color.theme.neonPink)
                    .padding(.top, 4)
            }
        }
    }

    private var statsGrid: some View {
        HStack(spacing: 30) {
            FinalStat(icon: "target", title: "平均正解率",
                      value: String(format: "%.1f%%", game.totalAccuracy),
                      color: Color.theme.correct)
            FinalStat(icon: "clock.fill", title: "平均タイム",
                      value: String(format: "%.1fs", game.averageTime),
                      color: Color.theme.neonBlue)
            FinalStat(icon: "flame.fill", title: "ベストコンボ",
                      value: "\(game.bestStreak)",
                      color: Color.theme.neonPink)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.theme.cardBackground)
        )
    }

    private var roundHistory: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("ラウンド履歴")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color.theme.textPrimary)
                .padding(.horizontal, 20)

            ForEach(Array(game.roundResults.enumerated()), id: \.element.id) { index, result in
                HStack {
                    Text("#\(index + 1)")
                        .font(.system(size: 13, weight: .bold, design: .monospaced))
                        .foregroundColor(Color.theme.textSecondary)
                        .frame(width: 30)

                    Text(result.trivia.category.emoji)

                    Text(result.trivia.displayText)
                        .font(.system(size: 13))
                        .foregroundColor(Color.theme.textPrimary)
                        .lineLimit(1)

                    Spacer()

                    Text(String(format: "%.0f%%", result.accuracy))
                        .font(.system(size: 13, weight: .semibold, design: .monospaced))
                        .foregroundColor(result.accuracy >= 80 ? Color.theme.correct : Color.theme.incorrect)

                    Text("\(result.score)pt")
                        .font(.system(size: 13, weight: .bold, design: .monospaced))
                        .foregroundColor(Color.theme.neonYellow)
                        .frame(width: 60, alignment: .trailing)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.theme.cardBackground.opacity(index % 2 == 0 ? 0.5 : 0.3))
                )
                .padding(.horizontal, 20)
            }
        }
    }

    private var buttonSection: some View {
        HStack(spacing: 16) {
            Button {
                game.returnToMenu()
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "house.fill")
                    Text("メニューに戻る")
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color.theme.textSecondary)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(
                    Capsule()
                        .fill(Color.theme.cardBackground)
                        .overlay(
                            Capsule()
                                .stroke(Color.theme.textSecondary.opacity(0.3), lineWidth: 1)
                        )
                )
            }
            .buttonStyle(.plain)

            Button {
                game.startGame(difficulty: game.difficulty)
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "arrow.counterclockwise")
                    Text("もう一回！")
                }
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
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
        }
    }
}

struct FinalStat: View {
    let icon: String
    let title: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(color)
            Text(value)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(color)
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(Color.theme.textSecondary)
        }
    }
}
