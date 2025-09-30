import SwiftUI

enum ThemeColor: String, Codable {
    case purrple
    case midnight
    case whiskerWhite
    case ginger
    case blush
    case matcha
    case cream
    case sky
    case lavender
    case rose

    var color: Color {
        switch self {
        case .purrple:
            return Color(red: 140 / 255, green: 105 / 255, blue: 230 / 255)
        case .midnight:
            return Color(red: 38 / 255, green: 45 / 255, blue: 68 / 255)
        case .whiskerWhite:
            return Color(red: 245 / 255, green: 245 / 255, blue: 240 / 255)
        case .ginger:
            return Color(red: 240 / 255, green: 155 / 255, blue: 65 / 255)
        case .blush:
            return Color(red: 255 / 255, green: 200 / 255, blue: 210 / 255)
        case .matcha:
            return Color(red: 170 / 255, green: 210 / 255, blue: 120 / 255)
        case .cream:
            return Color(red: 255 / 255, green: 240 / 255, blue: 210 / 255)
        case .sky:
            return Color(red: 150 / 255, green: 210 / 255, blue: 255 / 255)
        case .lavender:
            return Color(red: 220 / 255, green: 190 / 255, blue: 255 / 255)
        case .rose:
            return Color(red: 245 / 255, green: 120 / 255, blue: 140 / 255)
        }
    }
}

extension Color {
    static func themed(_ themeColor: ThemeColor) -> Color {
        themeColor.color
    }
}
