import SwiftUI

struct PawPrintBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                .themed(.cream).opacity(0.9),
                .themed(.lavender).opacity(0.4)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .overlay(alignment: .topTrailing) {
            GeometryReader { _ in
                Canvas { context, size in
                    let pawPath = Path { path in
                        path.addRoundedRect(in: CGRect(x: 0, y: 0, width: 18, height: 22), cornerSize: CGSize(width: 8, height: 8))
                        path.addEllipse(in: CGRect(x: 12, y: -8, width: 12, height: 12))
                        path.addEllipse(in: CGRect(x: 4, y: -12, width: 12, height: 12))
                        path.addEllipse(in: CGRect(x: -4, y: -8, width: 12, height: 12))
                        path.addEllipse(in: CGRect(x: -10, y: 0, width: 12, height: 12))
                    }

                    let pawCount = Int(size.width / 70)
                    for index in 0...pawCount {
                        let x = CGFloat(index) * 70
                        let y = CGFloat(index % 2 == 0 ? 40 : 110)
                        var transform = CGAffineTransform(translationX: x, y: y)
                        transform = transform.rotated(by: CGFloat(Double(index) * .pi / 8))
                        let resolvedPath = pawPath.applying(transform)
                        context.fill(resolvedPath, with: .color(.themed(.purrple).opacity(0.08)))
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    PawPrintBackground()
}
