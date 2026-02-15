import SwiftUI

enum AegisTheme {
    static let background = Color.black
    static let foreground = Color.white
    static let accent = Color(hex: 0xFF4F00)
    static let secondaryText = Color.white.opacity(0.75)
}

extension Color {
    init(hex: UInt32) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}
