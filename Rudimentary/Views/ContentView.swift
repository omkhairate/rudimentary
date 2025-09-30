import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var viewModel: BucketListViewModel
    @State private var showingAddSheet = false
    @State private var selectedItem: BucketItem?

    var body: some View {
        NavigationStack {
            ZStack {
                PawPrintBackground()
                ScrollView {
                    VStack(spacing: 24) {
                        header
                        statusPicker
                        ForEach(BucketItem.Status.allCases, id: \.id) { status in
                            bucketSection(for: status)
                        }
                        Spacer(minLength: 24)
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
                    .padding(.bottom, 120)
                }
            }
            .navigationTitle("Rudimentary")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    filterMenu
                }
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddSheet = true
                    } label: {
                        Label("Add", systemImage: "plus.circle.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.themed(.rose), .themed(.whiskerWhite))
                    }
                    .accessibilityLabel("Add new bucket list adventure")
                }
            }
        }
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search adventures")
        .sheet(item: $selectedItem) { item in
            AddBucketItemView(existingItem: item) { updated in
                viewModel.update(item: updated)
            }
        }
        .sheet(isPresented: $showingAddSheet) {
            AddBucketItemView { newItem in
                viewModel.add(item: newItem)
            }
        }
    }

    private var header: some View {
        VStack(spacing: 16) {
            CatMoodHeader(progress: viewModel.progress)
            CoupleProgressView(
                progress: viewModel.progress,
                completedCount: viewModel.completedCount,
                totalCount: viewModel.items.count
            )
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(.themed(.whiskerWhite).opacity(0.85))
                .shadow(color: .themed(.midnight).opacity(0.08), radius: 16, x: 0, y: 8)
        )
    }

    private var statusPicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(CatCategory.allCases) { category in
                    CategoryPill(category: category, isSelected: viewModel.selectedCategory == category) {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                            viewModel.selectedCategory = viewModel.selectedCategory == category ? nil : category
                        }
                    }
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 4)
        }
    }

    private var filterMenu: some View {
        Menu {
            Picker("Filter by category", selection: Binding(
                get: { viewModel.selectedCategory },
                set: { newValue in
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        viewModel.selectedCategory = newValue
                    }
                }
            )) {
                Text("All cats").tag(CatCategory?.none)
                ForEach(CatCategory.allCases) { category in
                    Label(category.rawValue, systemImage: category.iconName).tag(CatCategory?.some(category))
                }
            }

            Toggle(isOn: $viewModel.showCompleted) {
                Label("Show completed", systemImage: "checkmark.seal")
            }
        } label: {
            Label("Filters", systemImage: "line.3.horizontal.decrease.circle")
                .labelStyle(.titleAndIcon)
                .foregroundStyle(.themed(.midnight))
        }
        .menuStyle(.borderlessButton)
    }

    private func bucketSection(for status: BucketItem.Status) -> some View {
        let items = viewModel.items(for: status)
        return VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label(status.label, systemImage: status == .completed ? "checkmark.seal.fill" : "pawprint.fill")
                    .font(.headline)
                    .foregroundStyle(status == .completed ? .themed(.matcha) : .themed(.purrple))
                Spacer()
                if status == .completed {
                    Toggle("Show completed", isOn: $viewModel.showCompleted)
                        .labelsHidden()
                        .tint(.themed(.matcha))
                }
            }
            .padding(.horizontal, 4)

            if items.isEmpty {
                EmptySectionView(status: status, selectedCategory: viewModel.selectedCategory)
            } else {
                LazyVStack(spacing: 16) {
                    ForEach(items) { item in
                        BucketItemCard(item: item) {
                            viewModel.toggleCompletion(for: item)
                        }
                        .onTapGesture {
                            selectedItem = item
                        }
                        .contextMenu {
                            Button(role: .destructive) {
                                viewModel.remove(item: item)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(BucketListViewModel())
}
