import SwiftUI

struct CatMoodHeader: View {
    let progress: Double
    @State private var pawBounce = false

    var body: some View {
        HStack(alignment: .center, spacing: 18) {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.themed(.lavender).opacity(0.4))
                    .frame(width: 100, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(.themed(.lavender).opacity(0.6), lineWidth: 1.5)
                    )
                Image(systemName: catIcon)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.themed(.purrple), .themed(.whiskerWhite))
                    .font(.system(size: 48))
                    .scaleEffect(pawBounce ? 1.05 : 0.98)
                    .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: pawBounce)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(moodTitle)
                    .font(.title2.weight(.bold))
                    .foregroundStyle(.themed(.midnight))
                Text(moodSubtitle)
                    .font(.body)
                    .foregroundStyle(.secondary)
                HStack(spacing: 6) {
                    ForEach(0..<5) { index in
                        Image(systemName: index < Int(progress * 5) ? "heart.fill" : "heart")
                            .foregroundStyle(.themed(index < Int(progress * 5) ? .rose : .lavender))
                    }
                }
                .font(.footnote)
            }
        }
        .onAppear {
            pawBounce = true
        }
    }

    private var catIcon: String {
        switch progress {
        case 0:
            return "cat"
        case ..<0.4:
            return "pawprint.fill"
        case ..<0.7:
            return "heart.circle.fill"
        default:
            return "sun.max.fill"
        }
    }

    private var moodTitle: String {
        switch progress {
        case 0:
            return "New whisker wishes"
        case ..<0.34:
            return "Curious kittens"
        case ..<0.67:
            return "Purring partners"
        case ..<0.99:
            return "Love lions"
        default:
            return "Legendary lap cats"
        }
    }

    private var moodSubtitle: String {
        switch progress {
        case 0:
            return "Dream up your first memory together."
        case ..<0.34:
            return "You're stretching into new adventures."
        case ..<0.67:
            return "Snuggled into a cozy rhythm of dates."
        case ..<0.99:
            return "Only a few more paw prints to go!"
        default:
            return "Every memory is a soft place to land."
        }
    }
}

#Preview {
    CatMoodHeader(progress: 0.84)
        .padding()
        .previewLayout(.sizeThatFits)
}
