//
//  GroceryListViewModel.swift
//  Grocery List
//
//  Created by Daniel Cazorro on 16/08/2026.
//

import Foundation
import Observation

/// Owns everything the list screen needs that is *not* persisted by SwiftData:
/// the search query, the active filters and the user's display preferences.
///
/// Filtering happens in memory rather than in a `@Query` predicate because the
/// search also matches localized category names, which SwiftData cannot express
/// in a `#Predicate`.
@MainActor
@Observable
final class GroceryListViewModel {

    // MARK: Transient state

    var searchText: String = ""
    var selectedCategory: GroceryCategory?
    var selectedPriority: Priority?

    // MARK: Persisted preferences

    var showCompletedItems: Bool = true {
        didSet { defaults.set(showCompletedItems, forKey: Key.showCompleted) }
    }

    var sortOption: SortOption = .aisle {
        didSet { defaults.set(sortOption.rawValue, forKey: Key.sortOption) }
    }

    var groupByCategory: Bool = true {
        didSet { defaults.set(groupByCategory, forKey: Key.groupByCategory) }
    }

    private let defaults: UserDefaults

    private enum Key {
        static let showCompleted = "list.showCompletedItems"
        static let sortOption = "list.sortOption"
        static let groupByCategory = "list.groupByCategory"
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        showCompletedItems = defaults.object(forKey: Key.showCompleted) as? Bool ?? true
        groupByCategory = defaults.object(forKey: Key.groupByCategory) as? Bool ?? true
        sortOption = (defaults.string(forKey: Key.sortOption).flatMap(SortOption.init(rawValue:))) ?? .aisle
    }

    // MARK: - Sorting

    enum SortOption: String, CaseIterable, Identifiable, Sendable {
        case aisle
        case dateAdded
        case alphabetical
        case priority

        var id: String { rawValue }

        var name: LocalizedStringResource {
            switch self {
            case .aisle: "Aisle order"
            case .dateAdded: "Recently added"
            case .alphabetical: "A–Z"
            case .priority: "Priority"
            }
        }

        var symbol: String {
            switch self {
            case .aisle: "map"
            case .dateAdded: "calendar"
            case .alphabetical: "textformat"
            case .priority: "exclamationmark.triangle"
            }
        }
    }

    // MARK: - Filtering

    var isFilterActive: Bool {
        selectedCategory != nil || selectedPriority != nil || !showCompletedItems
    }

    /// Number of active filters, surfaced as a badge on the filter button.
    var activeFilterCount: Int {
        [selectedCategory != nil, selectedPriority != nil, !showCompletedItems]
            .count { $0 }
    }

    func resetFilters() {
        selectedCategory = nil
        selectedPriority = nil
        showCompletedItems = true
    }

    func filteredAndSortedItems(_ items: [Item]) -> [Item] {
        var result = items.filter(passesFilters)
        result.sort(by: sortComparator)
        return result
    }

    private func passesFilters(_ item: Item) -> Bool {
        if !showCompletedItems, item.isCompleted { return false }
        if let selectedCategory, item.category != selectedCategory { return false }
        if let selectedPriority, item.priority != selectedPriority { return false }
        return item.matches(searchText: searchText)
    }

    private var sortComparator: (Item, Item) -> Bool {
        switch sortOption {
        case .aisle:
            return { lhs, rhs in
                if lhs.category != rhs.category {
                    return lhs.category.aisleOrder < rhs.category.aisleOrder
                }
                return Self.titlePrecedes(lhs, rhs)
            }
        case .dateAdded:
            return { lhs, rhs in
                if lhs.createdAt != rhs.createdAt { return lhs.createdAt > rhs.createdAt }
                return Self.titlePrecedes(lhs, rhs)
            }
        case .alphabetical:
            return Self.titlePrecedes
        case .priority:
            return { lhs, rhs in
                if lhs.priority != rhs.priority { return lhs.priority > rhs.priority }
                return Self.titlePrecedes(lhs, rhs)
            }
        }
    }

    private static func titlePrecedes(_ lhs: Item, _ rhs: Item) -> Bool {
        lhs.title.localizedStandardCompare(rhs.title) == .orderedAscending
    }

    // MARK: - Sections

    struct Section: Identifiable {
        let category: GroceryCategory
        let items: [Item]

        var id: GroceryCategory { category }
    }

    /// Groups already-filtered items into aisle sections, preserving the order
    /// produced by ``filteredAndSortedItems(_:)`` inside each section.
    func sections(for items: [Item]) -> [Section] {
        Dictionary(grouping: items, by: \.category)
            .map { Section(category: $0.key, items: $0.value) }
            .sorted { $0.category.aisleOrder < $1.category.aisleOrder }
    }

    // MARK: - Sharing

    /// Plain-text export of everything still pending, grouped by aisle.
    func shareText(for items: [Item]) -> String {
        let pending = items.filter { !$0.isCompleted }
        var lines: [String] = ["🛒 \(String(localized: "Shopping List"))"]

        guard !pending.isEmpty else {
            lines.append("")
            lines.append(String(localized: "Nothing left to buy."))
            return lines.joined(separator: "\n")
        }

        for section in sections(for: pending) {
            lines.append("")
            lines.append("\(section.category.emoji) \(String(localized: section.category.name))")
            for item in section.items.sorted(by: Self.titlePrecedes) {
                var line = "  • \(item.title)"
                if item.hasMeaningfulQuantity { line += " (\(item.quantityDescription))" }
                if !item.notes.isEmpty { line += " — \(item.notes)" }
                lines.append(line)
            }
        }

        lines.append("")
        lines.append("—")
        lines.append(String(localized: "Shared from Grocery List"))
        return lines.joined(separator: "\n")
    }
}
