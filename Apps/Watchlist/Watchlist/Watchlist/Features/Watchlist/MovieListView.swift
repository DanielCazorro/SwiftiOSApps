//
//  MovieListView.swift
//  Watchlist
//
//  Created by Daniel Cazorro on 19/08/2026.
//

import SwiftUI
import SwiftData

/// The list itself, with the search term and ordering baked into its `@Query`.
///
/// Filtering in the database rather than in Swift is the whole point of this
/// split: SwiftUI rebuilds this view whenever the parent's parameters change,
/// and each rebuild issues a fresh, narrower fetch.
struct MovieListView: View {
    @Query private var movies: [Movie]

    private let emptyReason: (_ visibleCount: Int) -> WatchlistEmptyView.Reason?
    private let onToggleWatched: (Movie) -> Void
    private let onEdit: (Movie) -> Void
    private let onDelete: (Movie) -> Void

    init(
        searchText: String,
        sort: WatchlistSort,
        filter: WatchlistFilter,
        emptyReason: @escaping (_ visibleCount: Int) -> WatchlistEmptyView.Reason?,
        onToggleWatched: @escaping (Movie) -> Void,
        onEdit: @escaping (Movie) -> Void,
        onDelete: @escaping (Movie) -> Void
    ) {
        _movies = Query(
            filter: Movie.predicate(searchText: searchText, filter: filter),
            sort: sort.descriptors,
            animation: .snappy
        )
        self.emptyReason = emptyReason
        self.onToggleWatched = onToggleWatched
        self.onEdit = onEdit
        self.onDelete = onDelete
    }

    var body: some View {
        List {
            ForEach(movies) { movie in
                MovieRowView(
                    movie: movie,
                    onSelect: { onEdit(movie) },
                    onToggleWatched: { onToggleWatched(movie) }
                )
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        onDelete(movie)
                    } label: {
                        Label("action.delete", systemImage: "trash")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button {
                        onToggleWatched(movie)
                    } label: {
                        Label(
                            movie.isWatched ? "action.markAsPending" : "action.markAsWatched",
                            systemImage: movie.isWatched ? "arrow.uturn.backward" : "checkmark"
                        )
                    }
                    .tint(movie.isWatched ? .orange : .green)
                }
                .contextMenu {
                    Button {
                        onEdit(movie)
                    } label: {
                        Label("action.edit", systemImage: "pencil")
                    }
                    Button {
                        onToggleWatched(movie)
                    } label: {
                        Label(
                            movie.isWatched ? "action.markAsPending" : "action.markAsWatched",
                            systemImage: movie.isWatched ? "arrow.uturn.backward" : "checkmark.circle"
                        )
                    }
                    Divider()
                    Button(role: .destructive) {
                        onDelete(movie)
                    } label: {
                        Label("action.delete", systemImage: "trash")
                    }
                }
            }
        }
        .listStyle(.plain)
        .overlay {
            if let reason = emptyReason(movies.count) {
                WatchlistEmptyView(reason: reason)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MovieListView(
            searchText: "",
            sort: .dateAdded,
            filter: .all,
            emptyReason: { _ in nil },
            onToggleWatched: { _ in },
            onEdit: { _ in },
            onDelete: { _ in }
        )
        .navigationTitle("app.title")
    }
    .modelContainer(PreviewContainer.populated)
}
