//
//  GroceryCategory.swift
//  Grocery List
//
//  Created by Daniel Cazorro on 16/08/2026.
//

import SwiftUI

/// Aisle-style grouping for a grocery item.
///
/// `rawValue` is persisted in SwiftData, so the cases must never be renamed.
/// Presentation (name, symbol, tint) lives here so views stay declarative.
enum GroceryCategory: String, Codable, CaseIterable, Identifiable, Sendable {
    case fruitsVegetables = "fruits_vegetables"
    case bakery = "bakery"
    case meat = "meat"
    case dairy = "dairy"
    case cereals = "cereals"
    case pasta = "pasta"
    case canned = "canned"
    case frozen = "frozen"
    case snacks = "snacks"
    case beverages = "beverages"
    case condiments = "condiments"
    case household = "household"
    case personal = "personal"
    case other = "other"

    var id: String { rawValue }

    /// Declaration order doubles as the "walking through the store" order.
    var aisleOrder: Int { Self.allCases.firstIndex(of: self) ?? Self.allCases.count }

    var name: LocalizedStringResource {
        switch self {
        case .fruitsVegetables: "Fruit & Vegetables"
        case .bakery: "Bakery"
        case .meat: "Meat & Fish"
        case .dairy: "Dairy & Eggs"
        case .cereals: "Cereals & Grains"
        case .pasta: "Pasta & Rice"
        case .canned: "Canned Goods"
        case .frozen: "Frozen"
        case .snacks: "Snacks & Sweets"
        case .beverages: "Drinks"
        case .condiments: "Condiments & Sauces"
        case .household: "Household"
        case .personal: "Personal Care"
        case .other: "Other"
        }
    }

    var symbol: String {
        switch self {
        case .fruitsVegetables: "carrot"
        case .bakery: "birthday.cake"
        case .meat: "fish"
        case .dairy: "drop"
        case .cereals: "laurel.leading"
        case .pasta: "fork.knife"
        case .canned: "cylinder"
        case .frozen: "snowflake"
        case .snacks: "popcorn"
        case .beverages: "cup.and.saucer"
        case .condiments: "drop.triangle"
        case .household: "house"
        case .personal: "hands.sparkles"
        case .other: "bag"
        }
    }

    /// Used only in the plain-text export, where SF Symbols are unavailable.
    var emoji: String {
        switch self {
        case .fruitsVegetables: "🥬"
        case .bakery: "🥖"
        case .meat: "🥩"
        case .dairy: "🥛"
        case .cereals: "🌾"
        case .pasta: "🍝"
        case .canned: "🥫"
        case .frozen: "🧊"
        case .snacks: "🍿"
        case .beverages: "🥤"
        case .condiments: "🧂"
        case .household: "🧹"
        case .personal: "🧴"
        case .other: "📦"
        }
    }

    var tint: Color {
        switch self {
        case .fruitsVegetables: .green
        case .bakery: .brown
        case .meat: .red
        case .dairy: .blue
        case .cereals: .orange
        case .pasta: .yellow
        case .canned: .gray
        case .frozen: .cyan
        case .snacks: .pink
        case .beverages: .teal
        case .condiments: .indigo
        case .household: .mint
        case .personal: .purple
        case .other: .secondary
        }
    }
}
