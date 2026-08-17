//
//  PetFormViewModel.swift
//  Paws
//
//  Created by Daniel Cazorro on 17/08/2026.
//

import Foundation
import PhotosUI
import SwiftData
import SwiftUI

/// Holds a *draft* of a pet. Nothing touches the store until `save()` is
/// called, so cancelling a new pet no longer leaves an empty record behind.
@MainActor
@Observable
final class PetFormViewModel {

    enum Mode {
        case create
        case edit(Pet)
    }

    var name: String = ""
    var species: PetSpecies = .dog
    var breed: String = ""
    var notes: String = ""
    var hasBirthday: Bool = false
    var birthday: Date = .now
    var isFavorite: Bool = false
    var photo: Data?

    var photoPickerItem: PhotosPickerItem?
    private(set) var isLoadingPhoto: Bool = false
    var errorMessage: String?

    private let mode: Mode

    init(mode: Mode) {
        self.mode = mode

        if case .edit(let pet) = mode {
            name = pet.name
            species = pet.species
            breed = pet.breed
            notes = pet.notes
            isFavorite = pet.isFavorite
            photo = pet.photo
            if let birthday = pet.birthday {
                hasBirthday = true
                self.birthday = birthday
            }
        }
    }

    // MARK: - Presentation

    var navigationTitle: String {
        switch mode {
        case .create: String(localized: "New Pet", comment: "Form title")
        case .edit: String(localized: "Edit Pet", comment: "Form title")
        }
    }

    var canSave: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !isLoadingPhoto
    }

    var isEditing: Bool {
        if case .edit = mode { return true }
        return false
    }

    // MARK: - Photo

    func loadPhoto(from item: PhotosPickerItem?) async {
        guard let item else { return }
        isLoadingPhoto = true
        defer { isLoadingPhoto = false }

        do {
            guard let data = try await item.loadTransferable(type: Data.self) else {
                errorMessage = String(localized: "That photo could not be loaded.", comment: "Photo error")
                return
            }
            photo = ImageDownsampler.prepareForStorage(data)
        } catch {
            errorMessage = String(localized: "That photo could not be loaded.", comment: "Photo error")
        }
    }

    func removePhoto() {
        photo = nil
        photoPickerItem = nil
    }

    // MARK: - Persistence

    func save(in context: ModelContext) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }

        let pet: Pet
        switch mode {
        case .create:
            pet = Pet(name: trimmedName)
            context.insert(pet)
        case .edit(let existing):
            pet = existing
            pet.name = trimmedName
        }

        pet.species = species
        pet.breed = breed.trimmingCharacters(in: .whitespacesAndNewlines)
        pet.notes = notes.trimmingCharacters(in: .whitespacesAndNewlines)
        pet.birthday = hasBirthday ? birthday : nil
        pet.isFavorite = isFavorite
        pet.photo = photo

        do {
            try context.save()
        } catch {
            errorMessage = String(localized: "Your pet could not be saved.", comment: "Save error")
        }
    }
}
