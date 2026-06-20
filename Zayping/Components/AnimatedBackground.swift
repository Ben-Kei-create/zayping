import SwiftUI

struct Particle: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var size: CGFloat
    var opacity: Double
    var speed: CGFloat
    var hue: Double
}

struct AnimatedBackground: View {
    @State private var particles: [Particle] = []
    @State private var animationPhase: CGFloat = 0

    let particleCount = 30

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()

                ForEach(particles) { particle in
                    Circle()
                        .fill(
                            Color(hue: particle.hue, saturation: 0.7, brightness: 0.8)
                        )
                        .frame(width: particle.size, height: particle.size)
                        .position(
                            x: particle.x + sin(animationPhase * particle.speed) * 30,
                            y: particle.y + cos(animationPhase * particle.speed * 0.7) * 20
                        )
                        .opacity(particle.opacity)
                        .blur(radius: particle.size * 0.5)
                }

                RadialGradient(
                    colors: [
                        Color.theme.neonPurple.opacity(0.05),
                        Color.clear
                    ],
                    center: .topLeading,
                    startRadius: 100,
                    endRadius: 500
                )
                .ignoresSafeArea()

                RadialGradient(
                    colors: [
                        Color.theme.neonBlue.opacity(0.03),
                        Color.clear
                    ],
                    center: .bottomTrailing,
                    startRadius: 100,
                    endRadius: 600
                )
                .ignoresSafeArea()
            }
            .onAppear {
                particles = (0..<particleCount).map { _ in
                    Particle(
                        x: CGFloat.random(in: 0...geo.size.width),
                        y: CGFloat.random(in: 0...geo.size.height),
                        size: CGFloat.random(in: 2...6),
                        opacity: Double.random(in: 0.1...0.3),
                        speed: CGFloat.random(in: 0.3...1.5),
                        hue: Double.random(in: 0.5...0.85)
                    )
                }
                withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
                    animationPhase = .pi * 2
                }
            }
        }
    }
}
