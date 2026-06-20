import SwiftUI

struct CharacterCell: View {
    let state: CharacterState
    @State private var scale: CGFloat = 1.0
    @State private var shakeOffset: CGFloat = 0

    var body: some View {
        Text(String(state.character))
            .font(.system(size: 28, weight: .bold, design: .rounded))
            .foregroundColor(foregroundColor)
            .frame(width: 44, height: 52)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(backgroundColor)
                    .shadow(color: glowColor.opacity(0.5), radius: glowRadius)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .scaleEffect(scale)
            .offset(x: shakeOffset)
            .onChange(of: state.status) { _, newStatus in
                switch newStatus {
                case .correct:
                    withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                        scale = 1.15
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        withAnimation(.spring(response: 0.2, dampingFraction: 0.7)) {
                            scale = 1.0
                        }
                    }
                case .incorrect:
                    withAnimation(.default) {
                        shakeOffset = 8
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
                        withAnimation(.default) { shakeOffset = -6 }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.16) {
                        withAnimation(.default) { shakeOffset = 4 }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.24) {
                        withAnimation(.default) { shakeOffset = 0 }
                    }
                case .current:
                    withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                        scale = 1.05
                    }
                case .pending:
                    scale = 1.0
                }
            }
    }

    private var foregroundColor: Color {
        switch state.status {
        case .pending: return Color.theme.pending
        case .current: return Color.theme.currentHighlight
        case .correct: return Color.theme.correct
        case .incorrect: return Color.theme.incorrect
        }
    }

    private var backgroundColor: Color {
        switch state.status {
        case .pending: return Color.theme.cardBackground
        case .current: return Color.theme.currentHighlight.opacity(0.15)
        case .correct: return Color.theme.correct.opacity(0.15)
        case .incorrect: return Color.theme.incorrect.opacity(0.2)
        }
    }

    private var borderColor: Color {
        switch state.status {
        case .pending: return Color.clear
        case .current: return Color.theme.currentHighlight
        case .correct: return Color.theme.correct
        case .incorrect: return Color.theme.incorrect
        }
    }

    private var borderWidth: CGFloat {
        state.status == .pending ? 0 : 2
    }

    private var glowColor: Color {
        switch state.status {
        case .correct: return Color.theme.correct
        case .incorrect: return Color.theme.incorrect
        case .current: return Color.theme.currentHighlight
        default: return .clear
        }
    }

    private var glowRadius: CGFloat {
        switch state.status {
        case .correct, .incorrect, .current: return 6
        default: return 0
        }
    }
}
