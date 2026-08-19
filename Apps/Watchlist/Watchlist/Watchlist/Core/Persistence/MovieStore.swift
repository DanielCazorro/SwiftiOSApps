//
//  MovieStore.swift
//  Watchlist
//
//  Created by Daniel Cazorro on 19/08/2026.
//

import Foundation
import SwiftData

/// The single place that writes to the store.
///
/// Views describe *intent* ("add this film", "toggle that one") and never touch
/// `ModelContext` directly, so the persistence rules live in one file. It is a
/// value type wrapping the context, so building one per view body is free.
@MainActor
struct MovieStore {
    let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    // MARK: - Writing

    /// Inserts a film from a draft. Returns `nil` when the draft is not valid.
    @discardableResult
    func add(_ draft: MovieDraft) -> Movie? {
        guard let title = draft.sanitizedTitle else { return nil }
        let movie = Movie(
            title: title,
            genre: draft.genre,
            isWatched: draft.isWatched,
            rating: draft.isWatched ? draft.rating : 0,
            notes: draft.notes.trimmingCharacters(in: .whitespacesAndNewlines),
            dateWatched: draft.isWatched ? .now : nil
        )
        context.insert(movie)
        return movie
    }

    /// Commits a draft onto an existing film. Returns `false` when it is not valid.
    @discardableResult
    func update(_ movie: Movie, with draft: MovieDraft) -> Bool {
        guard let title = draft.sanitizedTitle else { return false }
        movie.title = title
        movie.genre = draft.genre
        movie.notes = draft.notes.trimmingCharacters(in: .whitespacesAndNewlines)

        // Going through the model's own transitions keeps `dateWatched` and the
        // rating consistent instead of leaving stale values behind.
        if draft.isWatched {
            movie.markAsWatched()
            movie.rating = draft.rating
        } else {
            movie.markAsUnwatched()
        }
        return true
    }

    func toggleWatched(_ movie: Movie) {
        movie.toggleWatched()
    }

    func delete(_ movie: Movie) {
        context.delete(movie)
    }

    /// Removes every film. Backs the "start over" destructive action.
    func deleteAll() throws {
        try context.delete(model: Movie.self)
    }

    // MARK: - Reading

    /// A random unwatched film, avoiding one recent pick so that "shuffle again"
    /// always moves on when there is anything else to show.
    func randomPendingMovie(excluding excluded: Movie? = nil) -> Movie? {
        let descriptor = FetchDescriptor<Movie>(
            predicate: Movie.predicate(searchText: "", filter: .pending)
        )
        guard let pending = try? context.fetch(descriptor), !pending.isEmpty else { return nil }

        let candidates = pending.filter { $0.persistentModelID != excluded?.persistentModelID }
        return (candidates.isEmpty ? pending : candidates).randomElement()
    }
}
