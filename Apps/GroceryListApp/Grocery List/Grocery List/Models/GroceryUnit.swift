//
//  GroceryUnit.swift
//  Grocery List
//
//  Created by Daniel Cazorro on 16/08/2026.
//

import Foundation

/// The unit a quantity is expressed in. `rawValue` is persisted, so keep it stable.
enum GroceryUnit: String, Codable, CaseIterable, Identifiable, Sendable {
    case piece
    case pack
    case gram
    case kilogram
    case litre
    case millilitre

    var id: String { rawValue }

    var name: LocalizedStringResource {
        switch self {
        case .piece: "Units"
        case .pack: "Packs"
        case .gram: "Grams"
        case .kilogram: "Kilograms"
        case .litre: "Litres"
        case .millilitre: "Millilitres"
        }
    }

    /// Short form appended to a quantity, e.g. `2 kg`. `nil` for plain counts,
    /// which read better as just `×2`.
    var abbreviation: LocalizedStringResource? {
        switch self {
        case .piece: nil
        case .pack: "pack"
        case .gram: "g"
        case .kilogram: "kg"
        case .litre: "L"
        case .millilitre: "ml"
        }
    }
}
