//
//  MovieRowView.swift
//  Watchlist
//
//  Created by Daniel Cazorro on 19/08/2026.
//

import SwiftUI

/// A single row of the watchlist.
///
/// The row is deliberately *not* a `Button`: a `Button` label is inert, so the
/// watched-state circle nested inside one would never receive taps. A tap
/// gesture on the row plus a real button for the circle keeps both working.
struct MovieRowView: View {
    let movie: Movie
    let onSelect: () -> Void
    let onToggleWatched: () -> Void

    var body: some View {
        HStack(spacing: Theme.Spacing.medium) {
            watchedToggle
            details
            Spacer(minLength: 0)
        }
        .padding(.vertical, Theme.Spacing.tight)
        .contentShape(.rect)
        .onTapGesture(perform: onSelect)
    }

    private var details: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.tight) {
            Text(movie.title)
                .font(.headline)
                .fontWeight(movie.isWatched ? .regular : .semibold)
                .foregroundStyle(movie.isWatched ? .secondary : .primary)
                .lineLimit(2)

            HStack(spacing: Theme.Spacing.small) {
                GenreBadge(genre: movie.genre)

                if let rating = movie.displayedRating {
                    StarRatingView(rating: .constant(rating), isEditable: false)
                        .font(.caption2)
                } else {
                    Text(movie.dateAdded.relativeDescription)
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                }
            }
        }
        // VoiceOver reads title + genre + rating as one item, and activating it
        // opens the editor — the same thing a tap does.
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(Text("row.hint.edit"))
        .accessibilityAction(.default, onSelect)
    }

    private var watchedToggle: some View {
        Button(action: onToggleWatched) {
            Image(systemName: movie.isWatched ? "checkmark.circle.fill" : "circle")
                .font(.title2)
                .foregroundStyle(movie.isWatched ? AnyShapeStyle(Theme.brand) : AnyShapeStyle(.tertiary))
                .contentTransition(.symbolEffect(.replace))
        }
        // `.plain` stops the row from treating every tap as this button's.
        .buttonStyle(.plain)
        .accessibilityLabel(Text(movie.isWatched ? "action.markAsPending" : "action.markAsWatched"))
        .sensoryFeedback(.impact(weight: .light), trigger: movie.isWatched)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    List {
        MovieRowView(movie: Movie(title: "Blade Runner", genre: .scifi), onSelect: {}, onToggleWatched: {})
        MovieRowView(
            movie: Movie(title: "Toy Story", genre: .kids, isWatched: true, rating: 5),
            onSelect: {},
            onToggleWatched: {}
        )
    }
}
