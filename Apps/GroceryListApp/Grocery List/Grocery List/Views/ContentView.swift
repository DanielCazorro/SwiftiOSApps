//
//  ContentView.swift
//  Grocery List
//
//  Created by Daniel Cazorro on 16/08/2026.
//

import SwiftUI
import SwiftData
import TipKit

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Item.createdAt, order: .reverse) private var items: [Item]

    @State private var viewModel = GroceryListViewModel()
    @State private var route: Route?
    @State private var editingItem: Item?
    @State private var isConfirmingClearAll = false
    @State private var mutationCount = 0

    private let starterListTip = StarterListTip()
    private let filterTip = FilterTip()
    private let statisticsTip = StatisticsTip()

    /// Sheets are modelled as one enum so only one can ever be presented.
    private enum Route: Identifiable, Hashable {
        case add, filters, statistics, settings

        var id: Self { self }
    }

    private var visibleItems: [Item] {
        viewModel.filteredAndSortedItems(items)
    }

    private var statistics: GroceryStatistics {
        GroceryStatistics(items: items)
    }

    var body: some View {
        NavigationStack {
            listContent
                .navigationTitle("Shopping List")
                .searchable(text: $viewModel.searchText, prompt: Text("Search items"))
                .toolbar { toolbarContent }
                .toolbarTitleDisplayMode(.large)
                .navigationDestination(for: Item.self) { item in
                    ItemDetailView(item: item)
                }
                .sheet(item: $route) { route in
                    sheet(for: route)
                }
                .sheet(item: $editingItem) { item in
                    AddEditItemView(item: item)
                }
                .confirmationDialog(
                    "Clear the whole list?",
                    isPresented: $isConfirmingClearAll,
                    titleVisibility: .visible
                ) {
                    Button("Delete \(items.count) items", role: .destructive, action: clearAll)
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("This removes every item, whether or not it's ticked off.")
                }
                .mutationFeedback(trigger: mutationCount)
                .animation(.snappy, value: visibleItems.map(\.persistentModelID))
                .onChange(of: items.count, initial: true) { _, count in
                    FilterTip.itemCount = count
                }
        }
    }

    // MARK: - List

    @ViewBuilder
    private var listContent: some View {
        if items.isEmpty {
            emptyState
        } else if visibleItems.isEmpty {
            noResultsState
        } else {
            List {
                ProgressSummaryView(statistics: statistics)

                if viewModel.groupByCategory {
                    ForEach(viewModel.sections(for: visibleItems)) { section in
                        Section {
                            ForEach(section.items) { item in
                                // The header already names the aisle.
                                row(for: item, showsCategory: false)
                            }
                        } header: {
                            CategoryHeader(category: section.category, count: section.items.count)
                        }
                    }
                } else {
                    Section {
                        ForEach(visibleItems) { item in
                            row(for: item)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
        }
    }

    private func row(for item: Item, showsCategory: Bool = true) -> some View {
        NavigationLink(value: item) {
            ItemRowView(item: item, onToggle: { toggle(item) }, showsCategory: showsCategory)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                delete(item)
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button {
                toggle(item)
            } label: {
                Label(
                    item.isCompleted ? "Undo" : "Done",
                    systemImage: item.isCompleted ? "arrow.uturn.backward" : "checkmark"
                )
            }
            .tint(item.isCompleted ? .orange : .green)
        }
        .contextMenu {
            Button { editingItem = item } label: {
                Label("Edit", systemImage: "pencil")
            }
            Button { duplicate(item) } label: {
                Label("Duplicate", systemImage: "plus.square.on.square")
            }
            Divider()
            Button(role: .destructive) { delete(item) } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }

    // MARK: - Empty states

    private var emptyState: some View {
        ContentUnavailableView {
            Label("Your cart is empty", systemImage: "cart")
        } description: {
            Text("Add what you need, or start from a list of everyday basics.")
        } actions: {
            Button("Add an item") { route = .add }
                .buttonStyle(.borderedProminent)

            Button("Use a starter list", action: addStarterList)
                .buttonStyle(.bordered)
                .popoverTip(starterListTip)
        }
    }

    private var noResultsState: some View {
        ContentUnavailableView {
            Label("No matches", systemImage: "line.3.horizontal.decrease.circle")
        } description: {
            Text("Nothing here matches your search and filters.")
        } actions: {
            Button("Reset filters") {
                withAnimation {
                    viewModel.resetFilters()
                    viewModel.searchText = ""
                }
            }
            .buttonStyle(.bordered)
        }
    }

    // MARK: - Toolbar

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            if !items.isEmpty {
                Button { route = .filters } label: {
                    Label("Filters", systemImage: filterSymbol)
                }
                .popoverTip(filterTip)
            }
        }

        ToolbarItem(placement: .topBarTrailing) {
            if !items.isEmpty {
                Menu {
                    Button { route = .statistics } label: {
                        Label("Statistics", systemImage: "chart.bar")
                    }

                    ShareLink(item: viewModel.shareText(for: items)) {
                        Label("Share list", systemImage: "square.and.arrow.up")
                    }

                    Section("Sort by") {
                        Picker("Sort by", selection: $viewModel.sortOption) {
                            ForEach(GroceryListViewModel.SortOption.allCases) { option in
                                Label(String(localized: option.name), systemImage: option.symbol)
                                    .tag(option)
                            }
                        }
                    }

                    Section {
                        Toggle(isOn: $viewModel.groupByCategory) {
                            Label("Group by aisle", systemImage: "square.stack.3d.up")
                        }
                        Button { route = .settings } label: {
                            Label("Settings", systemImage: "gear")
                        }
                    }

                    Section {
                        Button {
                            withAnimation { modelContext.undoManager?.undo() }
                        } label: {
                            Label("Undo", systemImage: "arrow.uturn.backward")
                        }
                        .disabled(modelContext.undoManager?.canUndo != true)

                        Button(role: .destructive) {
                            isConfirmingClearAll = true
                        } label: {
                            Label("Clear list", systemImage: "trash")
                        }
                    }
                } label: {
                    Label("More", systemImage: "ellipsis.circle")
                }
                .popoverTip(statisticsTip)
            }
        }

        ToolbarItem(placement: .topBarTrailing) {
            Button { route = .add } label: {
                Label("Add item", systemImage: "plus")
            }
        }
    }

    private var filterSymbol: String {
        viewModel.isFilterActive
            ? "line.3.horizontal.decrease.circle.fill"
            : "line.3.horizontal.decrease.circle"
    }

    @ViewBuilder
    private func sheet(for route: Route) -> some View {
        switch route {
        case .add:
            AddEditItemView()
        case .filters:
            FilterView(viewModel: viewModel)
        case .statistics:
            StatisticsView(statistics: statistics)
        case .settings:
            SettingsView(viewModel: viewModel)
        }
    }

    // MARK: - Actions

    private func toggle(_ item: Item) {
        withAnimation(.snappy) { item.toggleCompletion() }
        mutationCount += 1
        if item.isCompleted {
            Task { await StatisticsTip.itemCompleted.donate() }
        }
    }

    private func delete(_ item: Item) {
        withAnimation { modelContext.delete(item) }
        mutationCount += 1
    }

    private func duplicate(_ item: Item) {
        let copy = Item(
            title: item.title,
            category: item.category,
            priority: item.priority,
            notes: item.notes,
            quantity: item.quantity,
            unit: item.unit
        )
        withAnimation { modelContext.insert(copy) }
        mutationCount += 1
    }

    private func clearAll() {
        withAnimation {
            for item in items { modelContext.delete(item) }
        }
        mutationCount += 1
    }

    private func addStarterList() {
        withAnimation {
            for item in Item.sampleList() { modelContext.insert(item) }
        }
        mutationCount += 1
        starterListTip.invalidate(reason: .actionPerformed)
    }
}

// MARK: - Progress summary

private struct ProgressSummaryView: View {
    let statistics: GroceryStatistics

    var body: some View {
        Section {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("\(statistics.completedItems) of \(statistics.totalItems) done")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Spacer()

                    Text(statistics.completionRate, format: .percent.precision(.fractionLength(0)))
                        .font(.headline)
                        .foregroundStyle(statistics.completionRate == 1 ? .green : .primary)
                        .contentTransition(.numericText())
                }

                ProgressView(value: statistics.completionRate)
                    .tint(.green)

                if statistics.highPriorityPending > 0 {
                    Label(
                        "\(statistics.highPriorityPending) high priority pending",
                        systemImage: "exclamationmark.circle.fill"
                    )
                    .font(.caption)
                    .foregroundStyle(.red)
                }
            }
            .padding(.vertical, 4)
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Progress")
            .accessibilityValue(
                Text("\(statistics.completedItems) of \(statistics.totalItems) done")
            )
        }
    }
}

// MARK: - Section header

private struct CategoryHeader: View {
    let category: GroceryCategory
    let count: Int

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: category.symbol)
                .foregroundStyle(category.tint)
            Text(category.name)
            Spacer()
            Text(count, format: .number)
                .monospacedDigit()
                .foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .combine)
    }
}

// MARK: - Previews

#Preview("With items") {
    ContentView()
        .modelContainer(AppModelContainer.preview())
}

#Preview("Empty") {
    ContentView()
        .modelContainer(AppModelContainer.preview(seeded: false))
}
