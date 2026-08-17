//
//  Pet.swift
//  Paws
//
//  Created by Daniel Cazorro on 17/08/2026.
//

import Foundation
import SwiftData

@Model
final class Pet {
    /// Every stored property has a default value so SwiftData can perform a
    /// lightweight migration when the schema grows.
    var name: String = ""
    var speciesRaw: String = PetSpecies.other.rawValue
    var breed: String = ""
    var birthday: Date?
    var notes: String = ""
    var isFavorite: Bool = false
    var createdAt: Date = Date.now
    @Attribute(.externalStorage) var photo: Data?

    init(
        name: String,
        species: PetSpecies = .dog,
        breed: String = "",
        birthday: Date? = nil,
        notes: String = "",
        isFavorite: Bool = false,
        photo: Data? = nil
    ) {
        self.name = name
        self.speciesRaw = species.rawValue
        self.breed = breed
        self.birthday = birthday
        self.notes = notes
        self.isFavorite = isFavorite
        self.createdAt = .now
        self.photo = photo
    }
}

// MARK: - Derived values

extension Pet {
    var species: PetSpecies {
        get { PetSpecies(rawValue: speciesRaw) ?? .other }
        set { speciesRaw = newValue.rawValue }
    }

    /// Localized age ("2 years, 3 months") built by the system formatter, so it
    /// follows the user's language without extra translations.
    var ageDescription: String? {
        guard let birthday, birthday <= .now else { return nil }
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.year, .month, .day]
        formatter.maximumUnitCount = 2
        formatter.unitsStyle = .full
        let text = formatter.string(from: birthday, to: .now)
        return text?.isEmpty == false ? text : nil
    }

    /// Days left until the next birthday, or `nil` when no birthday is set.
    var daysUntilBirthday: Int? {
        guard let birthday else { return nil }
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        let components = calendar.dateComponents([.month, .day], from: birthday)
        guard let next = calendar.nextDate(
            after: today.addingTimeInterval(-1),
            matching: components,
            matchingPolicy: .nextTimePreservingSmallerComponents
        ) else { return nil }
        return calendar.dateComponents([.day], from: today, to: calendar.startOfDay(for: next)).day
    }

    var isBirthdayToday: Bool { daysUntilBirthday == 0 }

    /// Shown as a badge on the card when the birthday is around the corner.
    var isBirthdaySoon: Bool {
        guard let days = daysUntilBirthday else { return false }
        return days <= 30
    }

    /// Fallback used while the pet has no photo yet.
    var initials: String {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let words = trimmed.split(separator: " ").prefix(2)
        let letters = words.compactMap { $0.first }
        return letters.isEmpty ? "?" : String(letters).uppercased()
    }
}

// MARK: - Sample data

extension Pet {
    @MainActor
    static var preview: ModelContainer {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Pet.self, configurations: configuration)
        let calendar = Calendar.current

        let samples: [Pet] = [
            Pet(name: "Rexy", species: .dog, breed: "Labrador",
                birthday: calendar.date(byAdding: .month, value: -30, to: .now),
                notes: "Loves the beach.", isFavorite: true),
            Pet(name: "Bella", species: .cat, breed: "Siamese",
                birthday: calendar.date(byAdding: .year, value: -4, to: .now)),
            Pet(name: "Charlie", species: .dog, breed: "Beagle"),
            Pet(name: "Daisy", species: .rabbit, birthday: calendar.date(byAdding: .day, value: -400, to: .now)),
            Pet(name: "Fido", species: .dog, breed: "Border Collie", isFavorite: true),
            Pet(name: "Gus", species: .fish),
            Pet(name: "Mimi", species: .bird, breed: "Canary"),
            Pet(name: "Luna", species: .cat, breed: "Maine Coon")
        ]
        samples.forEach { container.mainContext.insert($0) }

        return container
    }
}
