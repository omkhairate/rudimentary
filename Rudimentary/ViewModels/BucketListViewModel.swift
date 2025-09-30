import Foundation
import SwiftUI

@MainActor
final class BucketListViewModel: ObservableObject {
    @Published private(set) var items: [BucketItem]
    @Published var selectedCategory: CatCategory? = nil
    @Published var searchText: String = ""
    @Published var showCompleted: Bool = true

    init(items: [BucketItem] = BucketListViewModel.sampleData) {
        self.items = items
    }

    var filteredItems: [BucketItem] {
        items.filter { item in
            let matchesCategory = selectedCategory.map { $0 == item.category } ?? true
            let matchesSearch = searchText.isEmpty || item.title.localizedCaseInsensitiveContains(searchText) || item.detail.localizedCaseInsensitiveContains(searchText)
            let matchesStatus = showCompleted || item.status != .completed
            return matchesCategory && matchesSearch && matchesStatus
        }
    }

    var progress: Double {
        guard !items.isEmpty else { return 0 }
        return Double(completedCount) / Double(items.count)
    }

    var completedCount: Int {
        items.filter { $0.status == .completed }.count
    }

    func items(for status: BucketItem.Status) -> [BucketItem] {
        filteredItems.filter { $0.status == status }
    }

    func add(item: BucketItem) {
        items.append(item)
    }

    func update(item: BucketItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[index] = item
    }

    func delete(at offsets: IndexSet, for status: BucketItem.Status) {
        let statusItems = items(for: status)
        let idsToDelete = offsets.compactMap { statusItems[safe: $0]?.id }
        items.removeAll { idsToDelete.contains($0.id) }
    }

    func remove(item: BucketItem) {
        items.removeAll { $0.id == item.id }
    }

    func toggleCompletion(for item: BucketItem) {
        var updated = item
        if updated.status == .completed {
            updated.status = .planned
            updated.dateCompleted = nil
        } else {
            updated.status = .completed
            updated.dateCompleted = Date()
        }
        update(item: updated)
    }
}

private extension BucketListViewModel {
    static let sampleData: [BucketItem] = [
        BucketItem(
            title: "Sunset picnic with cat-shaped bento",
            detail: "Craft adorable kitty rice balls and watch the sunset together at your favorite park.",
            category: .foodieForays,
            status: .planned,
            targetSeason: .summer,
            loveNote: "Don't forget the sparkling paw-secco!"
        ),
        BucketItem(
            title: "Adopt a houseplant and name it after a cat celebrity",
            detail: "Pick a leafy friend, design a cute tag, and take progress photos each month.",
            category: .bigDreams,
            status: .inProgress,
            targetSeason: .spring
        ),
        BucketItem(
            title: "Midnight fort movie marathon",
            detail: "Build a blanket fort, make cocoa, and watch animated cat classics all night.",
            category: .cozyNights,
            status: .completed,
            targetSeason: .winter,
            dateCompleted: Calendar.current.date(byAdding: .day, value: -12, to: Date()),
            loveNote: "You make every fort feel like home."
        ),
        BucketItem(
            title: "Volunteer at the local shelter",
            detail: "Spend a Saturday giving chin scratches, cleaning spaces, and delivering treats.",
            category: .caringActs,
            status: .planned,
            targetSeason: .autumn
        ),
        BucketItem(
            title: "Cat-venture photo scavenger hunt",
            detail: "Create a list of feline-inspired photo prompts and capture them across the city.",
            category: .playfulAdventures,
            status: .planned,
            targetSeason: .spring
        )
    ]
}

private extension Array {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
