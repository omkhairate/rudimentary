import SwiftUI

struct AddBucketItemView: View {
    @Environment(\.dismiss) private var dismiss

    var existingItem: BucketItem?
    var onSave: (BucketItem) -> Void

    @State private var title: String
    @State private var detail: String
    @State private var category: CatCategory
    @State private var status: BucketItem.Status
    @State private var season: Season?
    @State private var loveNote: String

    init(existingItem: BucketItem? = nil, onSave: @escaping (BucketItem) -> Void) {
        self.existingItem = existingItem
        self.onSave = onSave
        _title = State(initialValue: existingItem?.title ?? "")
        _detail = State(initialValue: existingItem?.detail ?? "")
        _category = State(initialValue: existingItem?.category ?? .cozyNights)
        _status = State(initialValue: existingItem?.status ?? .planned)
        _season = State(initialValue: existingItem?.targetSeason)
        _loveNote = State(initialValue: existingItem?.loveNote ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Adventure") {
                    TextField("Title", text: $title)
                    TextField("Description", text: $detail, axis: .vertical)
                        .lineLimit(3...5)
                }

                Section("Category") {
                    Picker("Category", selection: $category) {
                        ForEach(CatCategory.allCases) { category in
                            Label(category.rawValue, systemImage: category.iconName)
                                .tag(category)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }

                Section("Details") {
                    Picker("Status", selection: $status) {
                        ForEach(BucketItem.Status.allCases) { status in
                            Text(status.label).tag(status)
                        }
                    }

                    Picker("Season", selection: $season) {
                        Text("Anytime").tag(Season?.none)
                        ForEach(Season.allCases) { season in
                            Text("\(season.displayName) \(season.emoji)").tag(Season?.some(season))
                        }
                    }
                }

                Section("Love note") {
                    TextField("Add a sweet reminder", text: $loveNote, axis: .vertical)
                }
            }
            .navigationTitle(existingItem == nil ? "New Adventure" : "Edit Adventure")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                        .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }

    private func save() {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedDetail = detail.trimmingCharacters(in: .whitespacesAndNewlines)
        var item = existingItem ?? BucketItem(
            title: trimmedTitle,
            detail: trimmedDetail,
            category: category
        )
        item.title = trimmedTitle
        item.detail = trimmedDetail
        item.category = category
        item.status = status
        item.targetSeason = season
        item.loveNote = loveNote.trimmingCharacters(in: .whitespacesAndNewlines)
        onSave(item)
        dismiss()
    }
}

#Preview {
    AddBucketItemView { _ in }
}
