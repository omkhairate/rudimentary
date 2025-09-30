import SwiftUI

struct BucketItemCard: View {
    let item: BucketItem
    let onToggle: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                ZStack {
                    Circle()
                        .fill(.themed(item.category.palette.primary).opacity(0.2))
                        .frame(width: 48, height: 48)
                    Image(systemName: item.category.iconName)
                        .font(.title3)
                        .foregroundStyle(.themed(item.category.palette.primary))
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text(item.title)
                        .font(.headline)
                        .foregroundStyle(.themed(.midnight))
                        .multilineTextAlignment(.leading)
                    Text(item.detail)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.leading)
                    if let season = item.targetSeason {
                        Label("Dreaming of \(season.displayName) \(season.emoji)", systemImage: "calendar")
                            .font(.caption)
                            .foregroundStyle(.themed(item.category.palette.primary))
                    }
                    if !item.loveNote.isEmpty {
                        Label(item.loveNote, systemImage: "heart")
                            .font(.caption)
                            .foregroundStyle(.themed(item.category.palette.accent))
                            .padding(.top, 2)
                    }
                }

                Spacer()

                Button(action: onToggle) {
                    Image(systemName: item.status == .completed ? "checkmark.circle.fill" : "circle")
                        .font(.title3.weight(.semibold))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            item.status == .completed ? .themed(.matcha) : .themed(item.category.palette.primary),
                            .themed(.whiskerWhite)
                        )
                }
                .buttonStyle(.plain)
                .accessibilityLabel(item.status == .completed ? "Mark as planned" : "Mark as completed")
            }

            if item.status == .completed, let completedDate = item.dateCompleted {
                Label("Finished on \(completedDate.formatted(date: .abbreviated, time: .omitted))", systemImage: "sparkles")
                    .font(.caption)
                    .foregroundStyle(.themed(.matcha))
            } else {
                Text(item.celebratoryMessage)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(.themed(.whiskerWhite).opacity(0.95))
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .strokeBorder(.themed(item.category.palette.primary).opacity(0.22), lineWidth: 1.5)
                )
                .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 6)
        )
    }
}

#Preview {
    BucketItemCard(item: BucketListViewModel().items.first!) {}
        .padding()
        .previewLayout(.sizeThatFits)
}
