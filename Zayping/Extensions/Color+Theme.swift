import SwiftUI

extension Color {
    static let theme = ThemeColors()
}

struct ThemeColors {
    let background = Color(red: 0.08, green: 0.08, blue: 0.14)
    let cardBackground = Color(red: 0.12, green: 0.12, blue: 0.20)
    let neonBlue = Color(red: 0.2, green: 0.6, blue: 1.0)
    let neonGreen = Color(red: 0.0, green: 1.0, blue: 0.6)
    let neonPink = Color(red: 1.0, green: 0.3, blue: 0.5)
    let neonPurple = Color(red: 0.7, green: 0.3, blue: 1.0)
    let neonYellow = Color(red: 1.0, green: 0.9, blue: 0.2)
    let textPrimary = Color.white
    let textSecondary = Color(white: 0.6)
    let correct = Color(red: 0.0, green: 0.9, blue: 0.4)
    let incorrect = Color(red: 1.0, green: 0.2, blue: 0.3)
    let pending = Color(white: 0.3)
    let currentHighlight = Color(red: 0.3, green: 0.7, blue: 1.0)
}
