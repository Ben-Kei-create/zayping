import SwiftUI

struct GamePlayView: View {
    @EnvironmentObject var game: GameManager
    @FocusState private var isInputFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            topBar
                .padding(.horizontal, 30)
                .padding(.top, 20)

            Spacer().frame(height: 16)

            TimerBar(timeRemaining: game.timeRemaining, totalTime: game.difficulty.timeLimit)
                .padding(.horizontal, 30)

            Spacer().frame(height: 30)

            categoryBadge

            Spacer().frame(height: 20)

            characterGrid
                .padding(.horizontal, 30)

            Spacer().frame(height: 20)

            StreakIndicator(
                streak: game.streak,
                message: game.comboMessage,
                isVisible: game.showStreakEffect
            )
            .frame(height: 60)

            Spacer().frame(height: 10)

            inputField
                .padding(.horizontal, 100)

            Spacer()

            statsBar
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            isInputFocused = true
        }
    }

    private var topBar: some View {
        HStack {
            HStack(spacing: 6) {
                Image(systemName: "number")
                    .foregroundColor(Color.theme.neonBlue)
                Text("Round \(game.currentRound)/\(game.totalRounds)")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.theme.textPrimary)
            }

            Spacer()

            HStack(spacing: 6) {
                Image(systemName: "star.fill")
                    .foregroundColor(Color.theme.neonYellow)
                Text("\(game.score)")
                    .font(.system(size: 20, weight: .bold, design: .monospaced))
                    .foregroundColor(Color.theme.neonYellow)
            }
        }
    }

    private var categoryBadge: some View {
        Group {
            if let trivia = game.currentTrivia {
                HStack(spacing: 6) {
                    Text(trivia.category.emoji)
                    Text(trivia.category.rawValue)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(Color.theme.neonPurple)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(Color.theme.neonPurple.opacity(0.15))
                        .overlay(
                            Capsule()
                                .stroke(Color.theme.neonPurple.opacity(0.3), lineWidth: 1)
                        )
                )
            }
        }
    }

    private var characterGrid: some View {
        FlowLayout(spacing: 6) {
            ForEach(game.characters) { charState in
                CharacterCell(state: charState)
            }
        }
        .frame(maxWidth: 700)
    }

    private var inputField: some View {
        TextField("ここにタイピング...", text: Binding(
            get: { game.inputText },
            set: { game.processInput($0) }
        ))
        .textFieldStyle(.plain)
        .font(.system(size: 18, design: .rounded))
        .foregroundColor(Color.theme.textPrimary)
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.theme.cardBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.theme.neonBlue.opacity(0.3), lineWidth: 1)
                )
        )
        .focused($isInputFocused)
    }

    private var statsBar: some View {
        HStack(spacing: 30) {
            StatItem(icon: "checkmark.circle.fill", label: "正解",
                     value: "\(game.currentIndex)/\(game.characters.count)",
                     color: Color.theme.correct)

            StatItem(icon: "flame.fill", label: "コンボ",
                     value: "\(game.streak)",
                     color: .orange)

            StatItem(icon: "trophy.fill", label: "最高コンボ",
                     value: "\(game.bestStreak)",
                     color: Color.theme.neonYellow)
        }
    }
}

struct StatItem: View {
    let icon: String
    let label: String
    let value: String
    let color: Color

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 14))
            VStack(alignment: .leading, spacing: 1) {
                Text(label)
                    .font(.system(size: 10))
                    .foregroundColor(Color.theme.textSecondary)
                Text(value)
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                    .foregroundColor(Color.theme.textPrimary)
            }
        }
    }
}

struct FlowLayout: Layout {
    var spacing: CGFloat = 6

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = layout(proposal: proposal, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = layout(proposal: proposal, subviews: subviews)
        for (index, position) in result.positions.enumerated() {
            subviews[index].place(at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y), proposal: .unspecified)
        }
    }

    private func layout(proposal: ProposedViewSize, subviews: Subviews) -> (size: CGSize, positions: [CGPoint]) {
        let maxWidth = proposal.width ?? .infinity
        var positions: [CGPoint] = []
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        var maxX: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > maxWidth && x > 0 {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            positions.append(CGPoint(x: x, y: y))
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
            maxX = max(maxX, x)
        }

        return (CGSize(width: maxX, height: y + rowHeight), positions)
    }
}
