//
//  Nutrient.swift
//  Fruits
//
//  Created by Daniel Cazorro on 02/10/2026.
//

import Foundation

enum Nutrient: String, CaseIterable, Identifiable {
    case energy
    case sugar
    case fat
    case protein
    case vitamins
    case minerals

    var id: Self { self }

    var name: LocalizedStringResource {
        switch self {
        case .energy: "Energy"
        case .sugar: "Sugar"
        case .fat: "Fat"
        case .protein: "Protein"
        case .vitamins: "Vitamins"
        case .minerals: "Minerals"
        }
    }
}
