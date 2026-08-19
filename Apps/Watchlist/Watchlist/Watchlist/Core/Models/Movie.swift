//
//  Movie.swift
//  Watchlist
//
//  Created by Daniel Cazorro on 18/08/2026.
//

import Foundation
import SwiftData

/// A film the user wants to watch — or has already watched.
///
/// `genre` is persisted as its raw `Int` (`genreID`) rather than as the enum
/// itself: `#Predicate` and `SortDescriptor` can only reach stored properties of
/// primitive types, so keeping the raw value around is what makes queries like
/// "only sci-fi" possible.
@Model
final class Movie {
    var title: String = ""
    var genreID: Int = Genre.drama.rawValue
    var isWatched: Bool = false
    var rating: Int = 0
    var notes: String = ""
    var dateAdded: Date = Date.now
    var dateWatched: Date?

    init(
        title: String,
        genre: Genre,
        isWatched: Bool = false,
        rating: Int = 0,
        notes: String = "",
        dateAdded: Date = .now,
        dateWatched: Date? = nil
    ) {
        self.title = title
        self.genreID = genre.rawValue
        self.isWatched = isWatched
        self.rating = rating
        self.notes = notes
        self.dateAdded = dateAdded
        self.dateWatched = dateWatched
    }

    var genre: Genre {
        get { Genre(rawValue: genreID) ?? .drama }
        set { genreID = newValue.rawValue }
    }
}

// MARK: - Domain behaviour

extension Movie {
    /// Ratings only make sense once a film has actually been watched.
    var displayedRating: Int? {
        guard isWatched, rating > 0 else { return nil }
        return rating
    }

    func markAsWatched(on date: Date = .now) {
        guard !isWatched else { return }
        isWatched = true
        dateWatched = date
    }

    func markAsUnwatched() {
        guard isWatched else { return }
        isWatched = false
        dateWatched = nil
        rating = 0
    }

    func toggleWatched(on date: Date = .now) {
        isWatched ? markAsUnwatched() : markAsWatched(on: date)
    }
}

// MARK: - Validation

extension Movie {
    static let titleLengthLimit = 80

    /// Trims the title and rejects anything blank or over the length limit.
    /// Returns `nil` when the input is not a usable title.
    static func sanitizedTitle(from rawValue: String) -> String? {
        let trimmed = rawValue.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, trimmed.count <= titleLengthLimit else { return nil }
        return trimmed
    }
}
