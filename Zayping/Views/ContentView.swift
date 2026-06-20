import SwiftUI

struct ContentView: View {
    @EnvironmentObject var game: GameManager

    var body: some View {
        ZStack {
            AnimatedBackground()

            switch game.phase {
            case .menu:
                HomeView()
                    .transition(.asymmetric(
                        insertion: .opacity.combined(with: .scale(scale: 0.95)),
                        removal: .opacity
                    ))

            case .countdown(let count):
                CountdownOverlay(count: count)
                    .transition(.opacity)

            case .playing:
                GamePlayView()
                    .transition(.opacity)

            case .roundResult:
                RoundResultView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .opacity
                    ))

            case .gameOver:
                GameOverView()
                    .transition(.asymmetric(
                        insertion: .scale(scale: 0.8).combined(with: .opacity),
                        removal: .opacity
                    ))
            }
        }
        .animation(.easeInOut(duration: 0.4), value: game.phase)
    }
}

struct CountdownOverlay: View {
    let count: Int
    @State private var scale: CGFloat = 2.0
    @State private var opacity: Double = 0.0

    var body: some View {
        Text("\(count)")
            .font(.system(size: 120, weight: .black, design: .rounded))
            .foregroundStyle(
                LinearGradient(
                    colors: [Color.theme.neonBlue, Color.theme.neonPurple],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .shadow(color: Color.theme.neonBlue.opacity(0.5), radius: 20)
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                scale = 2.0
                opacity = 0
                withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                    scale = 1.0
                    opacity = 1.0
                }
            }
            .onChange(of: count) { _, _ in
                scale = 2.0
                opacity = 0
                withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                    scale = 1.0
                    opacity = 1.0
                }
            }
    }
}
