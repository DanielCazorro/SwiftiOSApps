//
//  Item.swift
//  Grocery List
//
//  Created by Daniel Cazorro on 16/08/2026.
//

import Foundation
import SwiftData

/// A single line on the shopping list.
///
/// Every stored property carries a default value so that adding new ones stays a
/// lightweight SwiftData migration instead of a breaking schema change.
@Model
final class Item {
    var title: String = ""
    var isCompleted: Bool = false
    var notes: String = ""
    var quantity: Int = 1
    var createdAt: Date = Date.now
    var completedAt: Date?

    // SwiftData persists primitives, so the enums are stored as raw values and
    // surfaced through the type-safe computed properties below.
    var categoryRawValue: String = GroceryCategory.other.rawValue
    var priorityRawValue: Int = Priority.medium.rawValue
    var unitRawValue: String = GroceryUnit.piece.rawValue

    var category: GroceryCategory {
        get { GroceryCategory(rawValue: categoryRawValue) ?? .other }
        set { categoryRawValue = newValue.rawValue }
    }

    var priority: Priority {
        get { Priority(rawValue: priorityRawValue) ?? .medium }
        set { priorityRawValue = newValue.rawValue }
    }

    var unit: GroceryUnit {
        get { GroceryUnit(rawValue: unitRawValue) ?? .piece }
        set { unitRawValue = newValue.rawValue }
    }

    init(
        title: String,
        isCompleted: Bool = false,
        category: GroceryCategory = .other,
        priority: Priority = .medium,
        notes: String = "",
        quantity: Int = 1,
        unit: GroceryUnit = .piece,
        createdAt: Date = .now
    ) {
        self.title = title
        self.isCompleted = isCompleted
        self.categoryRawValue = category.rawValue
        self.priorityRawValue = priority.rawValue
        self.unitRawValue = unit.rawValue
        self.notes = notes
        self.quantity = quantity
        self.createdAt = createdAt
        self.completedAt = isCompleted ? createdAt : nil
    }
}

// MARK: - Derived values

extension Item {
    /// `true` when the quantity is worth showing next to the title.
    var hasMeaningfulQuantity: Bool {
        quantity > 1 || unit != .piece
    }

    /// e.g. `×2`, `500 g`, `2 packs`.
    var quantityDescription: String {
        guard let abbreviation = unit.abbreviation else { return "×\(quantity)" }
        return "\(quantity) \(String(localized: abbreviation))"
    }

    func matches(searchText: String) -> Bool {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return true }
        return title.localizedCaseInsensitiveContains(query)
            || notes.localizedCaseInsensitiveContains(query)
            || String(localized: category.name).localizedCaseInsensitiveContains(query)
    }
}

// MARK: - Mutation

extension Item {
    func toggleCompletion() {
        isCompleted.toggle()
        completedAt = isCompleted ? .now : nil
    }

    /// Normalises free-text input coming from the editor.
    func apply(
        title: String,
        category: GroceryCategory,
        priority: Priority,
        quantity: Int,
        unit: GroceryUnit,
        notes: String
    ) {
        self.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        self.category = category
        self.priority = priority
        self.quantity = max(1, quantity)
        self.unit = unit
        self.notes = notes.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// MARK: - Sample data

extension Item {
    /// Seed list used by the "starter list" action and by previews.
    ///
    /// Titles are resolved through the string catalog at creation time: they are
    /// stored as plain text afterwards, so what matters is the user's language
    /// when they tap the button, not at render time.
    static func sampleList() -> [Item] {
        [
            Item(title: name("Bananas"), category: .fruitsVegetables, priority: .low, quantity: 6),
            Item(title: name("Spinach"), category: .fruitsVegetables, priority: .medium, quantity: 250, unit: .gram),
            Item(title: name("Wholewheat bread"), category: .bakery, priority: .medium),
            Item(title: name("Salmon fillet"), category: .meat, priority: .high, notes: name("Wild-caught if available"), quantity: 400, unit: .gram),
            Item(title: name("Free-range eggs"), category: .dairy, priority: .high, quantity: 2, unit: .pack),
            Item(title: name("Greek yoghurt"), category: .dairy, priority: .medium),
            Item(title: name("Brown rice"), category: .pasta, priority: .medium, quantity: 1, unit: .kilogram),
            Item(title: name("Olive oil"), category: .condiments, priority: .low, quantity: 1, unit: .litre)
        ]
    }

    private static func name(_ resource: LocalizedStringResource) -> String {
        String(localized: resource)
    }
}
