//
//  WatchlistViewModel.swift
//  Watchlist
//
//  Created by Daniel Cazorro on 19/08/2026.
//

import Foundation
import Observation
import SwiftData

/// Which form the sheet is currently showing, if any.
enum MovieFormRoute: Identifiable, Hashable {
    case create
    case edit(Movie)

    var id: String {
        switch self {
        case .create: "create"
        case .edit(let movie): "edit-\(movie.persistentModelID.hashValue)"
        }
    }
}

/// UI state and intents for the watchlist screen.
///
/// The list itself is *not* held here on purpose: `@Query` has to live in the
/// view to stay reactive to SwiftData changes. What this type owns is everything
/// the view would otherwise scatter across a handful of `@State` flags — the
/// search term, sort/filter choices, sheet routing and the shuffle logic — which
/// is also the part worth unit-testing.
@MainActor
@Observable
final class WatchlistViewModel {
    var searchText: String = ""
    var sort: WatchlistSort = .dateAdded
    var filter: WatchlistFilter = .all
    var formRoute: MovieFormRoute?
    var shuffledMovie: Movie?
    var isConfirmingDeleteAll: Bool = false

    private var lastShuffledMovie: Movie?

    // MARK: - Derived state

    var trimmedSearchText: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var isSearching: Bool { !trimmedSearchText.isEmpty }

    /// `true` when the toolbar should show that a non-default view is active.
    var hasActiveRefinements: Bool { filter != .all || sort != .dateAdded }

    /// Explains an empty list so the view can show the right message.
    func emptyReason(visibleCount: Int, totalCount: Int) -> WatchlistEmptyView.Reason? {
        guard visibleCount == 0 else { return nil }
        if totalCount == 0 { return .noMovies }
        if isSearching { return .noSearchResults(query: trimmedSearchText) }
        return .noneInFilter(filter)
    }

    // MARK: - Intents

    func addMovie() {
        formRoute = .create
    }

    func edit(_ movie: Movie) {
        formRoute = .edit(movie)
    }

    /// Picks a random unwatched film, avoiding an immediate repeat.
    func shuffle(using store: MovieStore) {
        let pick = store.randomPendingMovie(excluding: lastShuffledMovie)
        lastShuffledMovie = pick
        shuffledMovie = pick
    }

    func markShuffledMovieAsWatched(using store: MovieStore) {
        guard let movie = shuffledMovie else { return }
        store.toggleWatched(movie)
        shuffledMovie = nil
    }

    func toggleWatched(_ movie: Movie, using store: MovieStore) {
        store.toggleWatched(movie)
    }

    func delete(_ movie: Movie, using store: MovieStore) {
        // A deleted film must not linger in the shuffle sheet.
        if movie.persistentModelID == shuffledMovie?.persistentModelID { shuffledMovie = nil }
        if movie.persistentModelID == lastShuffledMovie?.persistentModelID { lastShuffledMovie = nil }
        store.delete(movie)
    }

    func deleteAll(using store: MovieStore) {
        shuffledMovie = nil
        lastShuffledMovie = nil
        try? store.deleteAll()
    }
}
