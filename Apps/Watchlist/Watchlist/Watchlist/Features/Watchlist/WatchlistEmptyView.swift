//
//  WatchlistEmptyView.swift
//  Watchlist
//
//  Created by Daniel Cazorro on 18/08/2026.
//

import SwiftUI

/// Empty states for the watchlist. Which one shows depends on *why* the list is
/// empty — a first launch and a search with no hits need very different copy.
struct WatchlistEmptyView: View {
    enum Reason: Equatable {
        case noMovies
        case noSearchResults(query: String)
        case noneInFilter(WatchlistFilter)
    }

    let reason: Reason

    var body: some View {
        switch reason {
        case .noMovies:
            onboarding
        case .noSearchResults(let query):
            ContentUnavailableView.search(text: query)
        case .noneInFilter(let filter):
            ContentUnavailableView(
                filter == .watched ? "empty.watched.title" : "empty.pending.title",
                systemImage: filter.symbolName,
                description: Text(filter == .watched ? "empty.watched.message" : "empty.pending.message")
            )
        }
    }

    private var onboarding: some View {
        VStack(spacing: Theme.Spacing.large) {
            artwork

            // A fixed height keeps the paged carousel from stretching to fill the
            // whole screen and stranding the artwork at the top.
            TabView {
                OnboardingPage(symbolName: "plus.circle", message: "onboarding.add.message")
                OnboardingPage(symbolName: "shuffle", message: "onboarding.shuffle.message")
                OnboardingPage(symbolName: "checkmark.circle", message: "onboarding.watched.message")
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .frame(maxWidth: 480)
            .frame(height: 190)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, Theme.Spacing.large)
        .padding(.bottom, Theme.Spacing.extraLarge)
    }

    private var artwork: some View {
        Circle()
            .fill(Theme.brand)
            .stroke(Color.accentColor.opacity(0.14), lineWidth: 24)
            .stroke(Color.accentColor.opacity(0.10), lineWidth: 52)
            .stroke(Color.accentColor.opacity(0.06), lineWidth: 84)
            .frame(width: 140, height: 140)
            .overlay {
                Image(systemName: "movieclapper.fill")
                    .font(.system(size: 62))
                    .foregroundStyle(Color(.systemBackground))
            }
            .accessibilityHidden(true)
    }
}

#Preview("First launch") {
    WatchlistEmptyView(reason: .noMovies)
}

#Preview("No results") {
    WatchlistEmptyView(reason: .noSearchResults(query: "Dune"))
}

#Preview("Nothing watched") {
    WatchlistEmptyView(reason: .noneInFilter(.watched))
}
