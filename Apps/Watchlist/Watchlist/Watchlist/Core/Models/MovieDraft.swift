//
//  MovieDraft.swift
//  Watchlist
//
//  Created by Daniel Cazorro on 19/08/2026.
//

import Foundation
import SwiftUI

/// The editable shape of a film, decoupled from the persisted `Movie`.
///
/// Editing a `@Model` object directly means every keystroke is written to the
/// store and "Cancel" has nothing left to undo. Working on a plain value and
/// committing it once on save keeps the sheet honest.
struct MovieDraft: Equatable {
    var title: String = ""
    var genre: Genre = .drama
    var isWatched: Bool = false
    var rating: Int = 0
    var notes: String = ""

    init() {}

    init(from movie: Movie) {
        title = movie.title
        genre = movie.genre
        isWatched = movie.isWatched
        rating = movie.rating
        notes = movie.notes
    }

    /// The title once trimmed, or `nil` when it cannot be saved.
    var sanitizedTitle: String? { Movie.sanitizedTitle(from: title) }

    var isValid: Bool { sanitizedTitle != nil }

    /// Why the draft cannot be saved yet, if it cannot.
    var validationMessage: LocalizedStringResource? {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty { return nil } // Don't scold before the user has typed.
        if trimmed.count > Movie.titleLengthLimit { return "form.error.titleTooLong" }
        return nil
    }
}
