//
//  PetListViewModel.swift
//  Paws
//
//  Created by Daniel Cazorro on 17/08/2026.
//

import Foundation
import SwiftData

/// Owns every piece of list state (search, filters, sorting, pending deletion)
/// and all the write operations, so `ContentView` only describes the layout.
@MainActor
@Observable
final class PetListViewModel {

    enum SortOption: String, CaseIterable, Identifiable {
        case name
        case recent
        case species

        var id: String { rawValue }

        var localizedName: String {
            switch self {
            case .name: String(localized: "Name", comment: "Sort option")
            case .recent: String(localized: "Recently added", comment: "Sort option")
            case .species: String(localized: "Species", comment: "Sort option")
            }
        }

        var symbol: String {
            switch self {
            case .name: "textformat.abc"
            case .recent: "clock"
            case .species: "pawprint"
            }
        }
    }

    var searchText: String = ""
    var sortOption: SortOption = .name
    var speciesFilter: PetSpecies?
    var showsFavoritesOnly: Bool = false
    var isPresentingNewPet: Bool = false
    var petPendingDeletion: Pet?

    var hasActiveFilters: Bool {
        speciesFilter != nil || showsFavoritesOnly || !trimmedSearch.isEmpty
    }

    private var trimmedSearch: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    // MARK: - Reading

    /// Applies search, filters and sorting to the `@Query` results.
    func visiblePets(from pets: [Pet]) -> [Pet] {
        pets
            .filter(matchesFilters)
            .sorted(by: isOrderedBefore)
    }

    private func matchesFilters(_ pet: Pet) -> Bool {
        if showsFavoritesOnly, !pet.isFavorite { return false }
        if let speciesFilter, pet.species != speciesFilter { return false }

        let query = trimmedSearch
        guard !query.isEmpty else { return true }
        return pet.name.localizedStandardContains(query)
            || pet.breed.localizedStandardContains(query)
            || pet.species.localizedName.localizedStandardContains(query)
    }

    private func isOrderedBefore(_ lhs: Pet, _ rhs: Pet) -> Bool {
        switch sortOption {
        case .name:
            lhs.name.localizedStandardCompare(rhs.name) == .orderedAscending
        case .recent:
            lhs.createdAt > rhs.createdAt
        case .species:
            lhs.species == rhs.species
                ? lhs.name.localizedStandardCompare(rhs.name) == .orderedAscending
                : lhs.species.localizedName.localizedStandardCompare(rhs.species.localizedName) == .orderedAscending
        }
    }

    /// Species that are actually present in the library, used to build the filter menu.
    func availableSpecies(in pets: [Pet]) -> [PetSpecies] {
        PetSpecies.allCases.filter { species in
            pets.contains { $0.species == species }
        }
    }

    // MARK: - Writing

    func toggleFavorite(_ pet: Pet, in context: ModelContext) {
        pet.isFavorite.toggle()
        save(context)
    }

    func confirmDeletion(of pet: Pet) {
        petPendingDeletion = pet
    }

    func deletePendingPet(in context: ModelContext) {
        guard let pet = petPendingDeletion else { return }
        context.delete(pet)
        petPendingDeletion = nil
        save(context)
    }

    func clearFilters() {
        searchText = ""
        speciesFilter = nil
        showsFavoritesOnly = false
    }

    private func save(_ context: ModelContext) {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            assertionFailure("Failed to save context: \(error.localizedDescription)")
        }
    }
}
