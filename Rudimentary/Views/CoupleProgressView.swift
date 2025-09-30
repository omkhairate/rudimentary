import SwiftUI

struct CoupleProgressView: View {
    let progress: Double
    let completedCount: Int
    let totalCount: Int

    var body: some View {
        VStack(spacing: 16) {
            ProgressRing(progress: progress)
                .frame(width: 120, height: 120)
            VStack(spacing: 6) {
                Text(progressTitle)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.themed(.midnight))
                Text("\(completedCount) of \(totalCount) memories captured")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .textCase(.uppercase)
                ShareLink(item: progressShareText) {
                    Label("Share your progress", systemImage: "square.and.arrow.up")
                        .font(.footnote.weight(.semibold))
                }
                .tint(.themed(.purrple))
                .padding(.top, 4)
            }
        }
    }

    private var progressTitle: String {
        switch progress {
        case 0:
            return "Let the adventures begin!"
        case ..<0.34:
            return "Paws on the path"
        case ..<0.67:
            return "Halfway to a cuddly milestone"
        case ..<0.99:
            return "Almost purrfection!"
        default:
            return "Purrfection achieved!"
        }
    }

    private var progressShareText: String {
        "We have completed \(completedCount) of \(totalCount) adventures in Rudimentary!"
    }
}

private struct ProgressRing: View {
    let progress: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(.themed(.lavender).opacity(0.3), style: StrokeStyle(lineWidth: 14, lineCap: .round))
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [.themed(.purrple), .themed(.rose), .themed(.matcha)]),
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 14, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.8), value: progress)
            Image(systemName: "heart.circle.fill")
                .symbolRenderingMode(.palette)
                .foregroundStyle(.themed(.rose), .themed(.whiskerWhite))
                .font(.system(size: 32))
        }
    }
}

#Preview {
    CoupleProgressView(progress: 0.72, completedCount: 6, totalCount: 8)
        .padding()
        .previewLayout(.sizeThatFits)
}
