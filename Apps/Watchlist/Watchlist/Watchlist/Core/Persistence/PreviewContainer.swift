//
//  PreviewContainer.swift
//  Watchlist
//
//  Created by Daniel Cazorro on 18/08/2026.
//

import Foundation
import SwiftData

/// In-memory containers for `#Preview` blocks and tests. Nothing here touches disk.
enum PreviewContainer {
    /// An empty store — useful for checking the onboarding / empty states.
    @MainActor static var empty: ModelContainer { makeContainer(with: []) }

    /// A populated store with a mix of pending and watched films.
    @MainActor static var populated: ModelContainer { makeContainer(with: sampleMovies) }

    @MainActor
    private static func makeContainer(with movies: [Movie]) -> ModelContainer {
        do {
            let container = try ModelContainer(
                for: Movie.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
            movies.forEach(container.mainContext.insert)
            return container
        } catch {
            // A failure here means the schema itself is broken, which is a
            // programmer error rather than something to recover from at runtime.
            fatalError("Failed to build the preview container: \(error)")
        }
    }

    @MainActor
    private static var sampleMovies: [Movie] {
        let now = Date.now
        return [
            Movie(title: "John Wick", genre: .action, dateAdded: now.addingTimeInterval(-86_400 * 1)),
            Movie(title: "Groundhog Day", genre: .comedy, dateAdded: now.addingTimeInterval(-86_400 * 2)),
            Movie(title: "Toy Story", genre: .kids, isWatched: true, rating: 5,
                  notes: "Still holds up.", dateAdded: now.addingTimeInterval(-86_400 * 3),
                  dateWatched: now.addingTimeInterval(-86_400 * 2)),
            Movie(title: "Blade Runner", genre: .scifi, dateAdded: now.addingTimeInterval(-86_400 * 4)),
            Movie(title: "The Lord of the Rings", genre: .fantasy, dateAdded: now.addingTimeInterval(-86_400 * 5)),
            Movie(title: "The Magnificent Seven", genre: .western, isWatched: true, rating: 4,
                  dateAdded: now.addingTimeInterval(-86_400 * 6),
                  dateWatched: now.addingTimeInterval(-86_400 * 3)),
            Movie(title: "The Revenant", genre: .drama, dateAdded: now.addingTimeInterval(-86_400 * 7)),
            Movie(title: "Dirty Dancing", genre: .romance, dateAdded: now.addingTimeInterval(-86_400 * 8))
        ]
    }
}
