//
//  GroceryStatistics.swift
//  Grocery List
//
//  Created by Daniel Cazorro on 16/08/2026.
//

import Foundation

/// A snapshot of list progress, derived from items rather than stored.
struct GroceryStatistics: Equatable, Sendable {
    struct CategoryCount: Identifiable, Equatable, Sendable {
        let category: GroceryCategory
        let pending: Int
        let completed: Int

        var id: GroceryCategory { category }
        var total: Int { pending + completed }
    }

    let totalItems: Int
    let completedItems: Int
    let highPriorityPending: Int
    let categoryCounts: [CategoryCount]

    var pendingItems: Int { totalItems - completedItems }

    var completionRate: Double {
        guard totalItems > 0 else { return 0 }
        return Double(completedItems) / Double(totalItems)
    }

    var isEmpty: Bool { totalItems == 0 }

    init(items: [Item]) {
        totalItems = items.count
        completedItems = items.count { $0.isCompleted }
        highPriorityPending = items.count { !$0.isCompleted && $0.priority == .high }

        let grouped = Dictionary(grouping: items, by: \.category)
        categoryCounts = grouped
            .map { category, items in
                CategoryCount(
                    category: category,
                    pending: items.count { !$0.isCompleted },
                    completed: items.count { $0.isCompleted }
                )
            }
            .sorted { lhs, rhs in
                // Busiest aisle first, falling back to aisle order so the chart
                // keeps a stable row order when counts tie.
                if lhs.pending != rhs.pending { return lhs.pending > rhs.pending }
                return lhs.category.aisleOrder < rhs.category.aisleOrder
            }
    }
}
