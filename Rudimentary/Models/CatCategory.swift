import Foundation

enum CatCategory: String, CaseIterable, Codable, Identifiable {
    case cozyNights = "Cozy Nights"
    case playfulAdventures = "Playful Adventures"
    case foodieForays = "Foodie Forays"
    case bigDreams = "Big Dreams"
    case caringActs = "Caring Acts"

    var id: String { rawValue }

    var iconName: String {
        switch self {
        case .cozyNights:
            return "moon.stars"
        case .playfulAdventures:
            return "pawprint"
        case .foodieForays:
            return "takeoutbag.and.cup.and.straw"
        case .bigDreams:
            return "sparkles"
        case .caringActs:
            return "heart"
        }
    }

    var palette: CatPalette {
        switch self {
        case .cozyNights:
            return CatPalette(primary: .purrple, secondary: .midnight, accent: .whiskerWhite)
        case .playfulAdventures:
            return CatPalette(primary: .ginger, secondary: .blush, accent: .whiskerWhite)
        case .foodieForays:
            return CatPalette(primary: .matcha, secondary: .cream, accent: .midnight)
        case .bigDreams:
            return CatPalette(primary: .sky, secondary: .lavender, accent: .whiskerWhite)
        case .caringActs:
            return CatPalette(primary: .rose, secondary: .cream, accent: .midnight)
        }
    }
}

struct CatPalette: Codable {
    let primary: ThemeColor
    let secondary: ThemeColor
    let accent: ThemeColor
}

enum Season: String, CaseIterable, Codable, Identifiable {
    case spring, summer, autumn, winter

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .spring:
            return "Spring"
        case .summer:
            return "Summer"
        case .autumn:
            return "Autumn"
        case .winter:
            return "Winter"
        }
    }

    var emoji: String {
        switch self {
        case .spring:
            return "🌸"
        case .summer:
            return "🌞"
        case .autumn:
            return "🍁"
        case .winter:
            return "❄️"
        }
    }
}
