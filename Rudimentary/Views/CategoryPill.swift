import SwiftUI

struct CategoryPill: View {
    let category: CatCategory
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: category.iconName)
                    .font(.caption.weight(.semibold))
                Text(category.rawValue)
                    .font(.caption.weight(.semibold))
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(background)
            .foregroundStyle(isSelected ? .themed(.whiskerWhite) : .themed(category.palette.primary))
            .overlay(
                Capsule().strokeBorder(borderColor, lineWidth: 1.2)
            )
            .clipShape(Capsule())
            .shadow(color: .black.opacity(isSelected ? 0.12 : 0.04), radius: isSelected ? 12 : 4, x: 0, y: isSelected ? 8 : 4)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Filter by \(category.rawValue)")
        .accessibilityAddTraits(isSelected ? [.isSelected] : [])
    }

    private var background: some View {
        Capsule()
            .fill(isSelected ? .themed(category.palette.primary) : .themed(.whiskerWhite).opacity(0.9))
    }

    private var borderColor: Color {
        isSelected ? .themed(category.palette.accent) : .themed(category.palette.primary).opacity(0.4)
    }
}

#Preview {
    CategoryPill(category: .playfulAdventures, isSelected: true, action: {})
        .padding()
        .previewLayout(.sizeThatFits)
}
