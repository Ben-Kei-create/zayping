import SwiftUI

struct TimerBar: View {
    let timeRemaining: TimeInterval
    let totalTime: TimeInterval

    private var progress: Double {
        guard totalTime > 0 else { return 0 }
        return timeRemaining / totalTime
    }

    private var barColor: Color {
        if progress > 0.5 { return Color.theme.neonGreen }
        if progress > 0.25 { return Color.theme.neonYellow }
        return Color.theme.incorrect
    }

    var body: some View {
        VStack(spacing: 4) {
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.theme.cardBackground)

                    RoundedRectangle(cornerRadius: 4)
                        .fill(
                            LinearGradient(
                                colors: [barColor, barColor.opacity(0.7)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geo.size.width * progress)
                        .shadow(color: barColor.opacity(0.5), radius: 4)
                }
            }
            .frame(height: 8)

            Text(String(format: "%.1f秒", timeRemaining))
                .font(.system(size: 14, weight: .bold, design: .monospaced))
                .foregroundColor(barColor)
        }
        .animation(.linear(duration: 0.1), value: timeRemaining)
    }
}
