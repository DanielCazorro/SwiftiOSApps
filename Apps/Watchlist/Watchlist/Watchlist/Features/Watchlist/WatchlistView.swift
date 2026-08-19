//
//  WatchlistView.swift
//  Watchlist
//
//  Created by Daniel Cazorro on 18/08/2026.
//

import SwiftUI
import SwiftData

/// Root screen: search, sort, filter, shuffle and everything that mutates the list.
struct WatchlistView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var model = WatchlistViewModel()

    /// Every film, kept here for two reasons: the empty state has to tell "no
    /// films yet" from "no matches", and observing this query is what makes the
    /// floating bar react when the last unwatched film disappears. A watchlist is
    /// small enough that one extra fetch costs nothing.
    @Query private var allMovies: [Movie]

    private var store: MovieStore { MovieStore(context: modelContext) }

    private var pendingCount: Int { allMovies.count { !$0.isWatched } }

    var body: some View {
        NavigationStack {
            MovieListView(
                searchText: model.trimmedSearchText,
                sort: model.sort,
                filter: model.filter,
                emptyReason: { model.emptyReason(visibleCount: $0, totalCount: allMovies.count) },
                onToggleWatched: { model.toggleWatched($0, using: store) },
                onEdit: { model.edit($0) },
                onDelete: { movie in
                    withAnimation(Theme.listAnimation) { model.delete(movie, using: store) }
                }
            )
            .navigationTitle("app.title")
            .navigationBarTitleDisplayMode(.large)
            .searchable(
                text: $model.searchText,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: Text("search.prompt")
            )
            .toolbar { toolbarContent }
            .safeAreaInset(edge: .bottom) { actionBar }
            .sheet(item: $model.formRoute) { route in
                MovieFormView(route: route)
            }
            .sheet(item: $model.shuffledMovie) { movie in
                ShuffleResultView(
                    movie: movie,
                    onShuffleAgain: { withAnimation { model.shuffle(using: store) } },
                    onMarkAsWatched: {
                        withAnimation(Theme.listAnimation) { model.markShuffledMovieAsWatched(using: store) }
                    }
                )
            }
            .confirmationDialog(
                "deleteAll.title",
                isPresented: $model.isConfirmingDeleteAll,
                titleVisibility: .visible
            ) {
                Button("deleteAll.confirm", role: .destructive) {
                    withAnimation(Theme.listAnimation) { model.deleteAll(using: store) }
                }
                Button("action.cancel", role: .cancel) {}
            } message: {
                Text("deleteAll.message")
            }
        }
    }

    // MARK: - Toolbar

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Menu {
                Picker(selection: $model.filter) {
                    ForEach(WatchlistFilter.allCases) { filter in
                        Label(String(localized: filter.name), systemImage: filter.symbolName)
                            .tag(filter)
                    }
                } label: {
                    Text("menu.show")
                }

                Picker(selection: $model.sort) {
                    ForEach(WatchlistSort.allCases) { sort in
                        Label(String(localized: sort.name), systemImage: sort.symbolName)
                            .tag(sort)
                    }
                } label: {
                    Text("menu.sortBy")
                }

                if !allMovies.isEmpty {
                    Section {
                        Button(role: .destructive) {
                            model.isConfirmingDeleteAll = true
                        } label: {
                            Label("deleteAll.action", systemImage: "trash")
                        }
                    }
                }
            } label: {
                Label(
                    "menu.options",
                    systemImage: model.hasActiveRefinements
                        ? "line.3.horizontal.decrease.circle.fill"
                        : "line.3.horizontal.decrease.circle"
                )
            }
        }
    }

    // MARK: - Floating actions

    private var actionBar: some View {
        HStack(alignment: .bottom) {
            if pendingCount >= 2 {
                Button {
                    model.shuffle(using: store)
                } label: {
                    Image(systemName: "shuffle")
                }
                .buttonStyle(.circularGlass)
                .accessibilityLabel(Text("action.shuffle"))
                .accessibilityHint(Text("action.shuffle.hint"))
                .transition(.scale.combined(with: .opacity))
            }

            Spacer(minLength: 0)

            Button {
                model.addMovie()
            } label: {
                Image(systemName: "plus")
            }
            .buttonStyle(.circularProminent)
            .accessibilityLabel(Text("action.addMovie"))
        }
        .padding(.horizontal, Theme.Spacing.large)
        .padding(.bottom, Theme.Spacing.small)
        .animation(Theme.listAnimation, value: pendingCount)
        // A soft scrim keeps rows from colliding with the floating controls as
        // they scroll past, without boxing the buttons into an opaque bar.
        .background {
            LinearGradient(
                colors: [Color(.systemBackground).opacity(0), Color(.systemBackground)],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 140)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .allowsHitTesting(false)
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview("Sample data") {
    WatchlistView()
        .modelContainer(PreviewContainer.populated)
}

#Preview("Empty") {
    WatchlistView()
        .modelContainer(PreviewContainer.empty)
}

#Preview("Español") {
    WatchlistView()
        .modelContainer(PreviewContainer.populated)
        .environment(\.locale, .init(identifier: "es"))
}
