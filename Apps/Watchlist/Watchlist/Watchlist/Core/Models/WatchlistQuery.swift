//
//  WatchlistQuery.swift
//  Watchlist
//
//  Created by Daniel Cazorro on 19/08/2026.
//

import Foundation
import SwiftUI
import SwiftData

/// How the list is ordered.
enum WatchlistSort: String, CaseIterable, Identifiable, Sendable {
    case dateAdded
    case title
    case genre

    var id: String { rawValue }

    var name: LocalizedStringResource {
        switch self {
        case .dateAdded: "sort.dateAdded"
        case .title: "sort.title"
        case .genre: "sort.genre"
        }
    }

    var symbolName: String {
        switch self {
        case .dateAdded: "clock"
        case .title: "textformat.abc"
        case .genre: "tag"
        }
    }

    /// Secondary descriptors keep the order stable when the primary key ties.
    var descriptors: [SortDescriptor<Movie>] {
        switch self {
        case .dateAdded:
            [SortDescriptor(\.dateAdded, order: .reverse)]
        case .title:
            [SortDescriptor(\.title, comparator: .localizedStandard),
             SortDescriptor(\.dateAdded, order: .reverse)]
        case .genre:
            [SortDescriptor(\.genreID),
             SortDescriptor(\.title, comparator: .localizedStandard)]
        }
    }
}

/// Which slice of the watchlist is on screen.
enum WatchlistFilter: String, CaseIterable, Identifiable, Sendable {
    case all
    case pending
    case watched

    var id: String { rawValue }

    var name: LocalizedStringResource {
        switch self {
        case .all: "filter.all"
        case .pending: "filter.pending"
        case .watched: "filter.watched"
        }
    }

    var symbolName: String {
        switch self {
        case .all: "film.stack"
        case .pending: "bookmark"
        case .watched: "checkmark.circle"
        }
    }

    /// `nil` means "no watched-state constraint".
    var isWatched: Bool? {
        switch self {
        case .all: nil
        case .pending: false
        case .watched: true
        }
    }
}

// MARK: - Predicate

extension Movie {
    /// Builds the `#Predicate` for a search term plus a watched-state filter.
    ///
    /// The search term is lifted into a local constant first — the macro can only
    /// capture plain values, not property accesses — and each filter gets its own
    /// literal predicate. Trying to fold the three cases into one expression needs
    /// an optional comparison, which reads worse and translates worse to SQL.
    static func predicate(searchText: String, filter: WatchlistFilter) -> Predicate<Movie> {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        switch filter {
        case .all:
            return #Predicate<Movie> { movie in
                query.isEmpty || movie.title.localizedStandardContains(query)
            }
        case .pending:
            return #Predicate<Movie> { movie in
                (query.isEmpty || movie.title.localizedStandardContains(query)) && !movie.isWatched
            }
        case .watched:
            return #Predicate<Movie> { movie in
                (query.isEmpty || movie.title.localizedStandardContains(query)) && movie.isWatched
            }
        }
    }
}
