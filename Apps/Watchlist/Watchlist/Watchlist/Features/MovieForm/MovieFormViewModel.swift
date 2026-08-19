//
//  MovieFormViewModel.swift
//  Watchlist
//
//  Created by Daniel Cazorro on 19/08/2026.
//

import Foundation
import Observation
import SwiftData

/// Drives the add/edit sheet. One view model serves both modes: the only
/// difference is whether there is an existing `Movie` to commit onto.
@MainActor
@Observable
final class MovieFormViewModel {
    private let editedMovie: Movie?

    var draft: MovieDraft

    init(route: MovieFormRoute) {
        switch route {
        case .create:
            editedMovie = nil
            draft = MovieDraft()
        case .edit(let movie):
            editedMovie = movie
            draft = MovieDraft(from: movie)
        }
    }

    // MARK: - Derived state

    var isEditing: Bool { editedMovie != nil }

    var navigationTitle: LocalizedStringResource {
        isEditing ? "form.title.edit" : "form.title.new"
    }

    var saveButtonTitle: LocalizedStringResource {
        isEditing ? "action.save" : "action.add"
    }

    var canSave: Bool {
        guard draft.isValid else { return false }
        // Nothing changed — no point in offering a save.
        return editedMovie.map { MovieDraft(from: $0) != draft } ?? true
    }

    var validationMessage: LocalizedStringResource? { draft.validationMessage }

    var remainingTitleCharacters: Int {
        Movie.titleLengthLimit - draft.title.trimmingCharacters(in: .whitespacesAndNewlines).count
    }

    /// Only warn as the user approaches the limit, not for the whole time.
    var showsCharacterCount: Bool { remainingTitleCharacters <= 20 }

    // MARK: - Intents

    /// Commits the draft. Returns `false` if the sheet should stay open.
    @discardableResult
    func save(using store: MovieStore) -> Bool {
        guard draft.isValid else { return false }

        if let movie = editedMovie {
            return store.update(movie, with: draft)
        }
        return store.add(draft) != nil
    }
}
