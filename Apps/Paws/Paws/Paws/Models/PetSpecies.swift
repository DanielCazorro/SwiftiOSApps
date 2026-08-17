//
//  PetSpecies.swift
//  Paws
//
//  Created by Daniel Cazorro on 17/08/2026.
//

import SwiftUI

/// The kind of animal a `Pet` is. Stored as a raw `String` so the SwiftData
/// store keeps working if new cases are added later.
enum PetSpecies: String, CaseIterable, Identifiable, Codable {
    case dog
    case cat
    case bird
    case rabbit
    case fish
    case reptile
    case other

    var id: String { rawValue }

    /// SF Symbol used on cards, chips and pickers.
    var symbol: String {
        switch self {
        case .dog: "dog.fill"
        case .cat: "cat.fill"
        case .bird: "bird.fill"
        case .rabbit: "hare.fill"
        case .fish: "fish.fill"
        case .reptile: "lizard.fill"
        case .other: "pawprint.fill"
        }
    }

    var tint: Color {
        switch self {
        case .dog: .brandPrimary
        case .cat: .brandSecondary
        case .bird: .cyan
        case .rabbit: .pink
        case .fish: .blue
        case .reptile: .green
        case .other: .purple
        }
    }

    /// Placeholder background used when a pet has no photo yet.
    var gradient: LinearGradient {
        LinearGradient(
            colors: [tint.mix(with: .white, by: 0.15), tint.mix(with: .black, by: 0.18)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    var localizedName: String {
        switch self {
        case .dog: String(localized: "Dog", comment: "Pet species")
        case .cat: String(localized: "Cat", comment: "Pet species")
        case .bird: String(localized: "Bird", comment: "Pet species")
        case .rabbit: String(localized: "Rabbit", comment: "Pet species")
        case .fish: String(localized: "Fish", comment: "Pet species")
        case .reptile: String(localized: "Reptile", comment: "Pet species")
        case .other: String(localized: "Other", comment: "Pet species")
        }
    }
}
