import SwiftUI

struct EmptySectionView: View {
    let status: BucketItem.Status
    let selectedCategory: CatCategory?

    private var message: String {
        switch (status, selectedCategory) {
        case (.planned, .some(let category)):
            return "No \(category.rawValue.lowercased()) plans yet. Tap + to dream one up!"
        case (.planned, .none):
            return "Let's paw-nder your next adventure."
        case (.inProgress, _):
            return "Time to chase a new idea together!"
        case (.completed, .some(let category)):
            return "No finished memories in \(category.rawValue.lowercased()) yet—keep prowling!"
        case (.completed, .none):
            return "Complete an adventure and it will curl up here."
        }
    }

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: status == .completed ? "medal.fill" : "cat")
                .font(.system(size: 40))
                .foregroundStyle(.themed(.lavender))
            Text(message)
                .font(.subheadline.weight(.medium))
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(.themed(.lavender).opacity(0.35), lineWidth: 1.4)
                .background(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(.themed(.whiskerWhite).opacity(0.55))
                )
        )
    }
}

#Preview {
    EmptySectionView(status: .planned, selectedCategory: .playfulAdventures)
        .padding()
}
