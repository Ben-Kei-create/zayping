import SwiftUI

struct StreakIndicator: View {
    let streak: Int
    let message: String
    let isVisible: Bool

    var body: some View {
        VStack(spacing: 4) {
            if streak >= 5 {
                HStack(spacing: 6) {
                    Image(systemName: "flame.fill")
                        .foregroundColor(flameColor)
                        .font(.system(size: 20))

                    Text("\(streak) コンボ")
                        .font(.system(size: 18, weight: .black, design: .rounded))
                        .foregroundColor(flameColor)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(flameColor.opacity(0.15))
                        .overlay(
                            Capsule()
                                .stroke(flameColor.opacity(0.5), lineWidth: 1)
                        )
                )
            }

            if isVisible {
                Text(message)
                    .font(.system(size: 24, weight: .black, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.theme.neonYellow, Color.theme.neonPink],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .shadow(color: Color.theme.neonYellow.opacity(0.5), radius: 10)
                    .transition(.asymmetric(
                        insertion: .scale(scale: 0.5).combined(with: .opacity),
                        removal: .opacity
                    ))
            }
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: streak)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isVisible)
    }

    private var flameColor: Color {
        if streak >= 20 { return Color.theme.neonPink }
        if streak >= 10 { return Color.theme.neonYellow }
        return Color.orange
    }
}
