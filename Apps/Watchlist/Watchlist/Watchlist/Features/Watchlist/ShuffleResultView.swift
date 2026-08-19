//
//  ShuffleResultView.swift
//  Watchlist
//
//  Created by Daniel Cazorro on 19/08/2026.
//

import SwiftUI
import SwiftData

/// Presents the film the shuffle landed on.
///
/// The original build used an `alert` whose *title* was the film name, which
/// gave no context and no way to act on the result. A small sheet can show the
/// genre and offer the two things the user actually wants next.
struct ShuffleResultView: View {
    let movie: Movie
    let onShuffleAgain: () -> Void
    let onMarkAsWatched: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: Theme.Spacing.large) {
            Text("shuffle.title")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)

            VStack(spacing: Theme.Spacing.medium) {
                Image(systemName: movie.genre.symbolName)
                    .font(.system(size: 44))
                    .foregroundStyle(movie.genre.tint.gradient)
                    .symbolEffect(.bounce, options: .nonRepeating)
                    .accessibilityHidden(true)

                Text(movie.title)
                    .font(.largeTitle.weight(.bold))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.6)

                GenreBadge(genre: movie.genre)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, Theme.Spacing.extraLarge)
            .background(movie.genre.tint.opacity(0.10), in: .rect(cornerRadius: Theme.Radius.card))

            VStack(spacing: Theme.Spacing.medium) {
                Button(action: onMarkAsWatched) {
                    Label("shuffle.watchedIt", systemImage: "checkmark.circle.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)

                Button(action: onShuffleAgain) {
                    Label("shuffle.again", systemImage: "shuffle")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            }
            .controlSize(.large)
        }
        .padding(Theme.Spacing.large)
        .frame(maxHeight: .infinity, alignment: .center)
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
        .presentationBackground(.regularMaterial)
        .overlay(alignment: .topTrailing) {
            Button("action.close", systemImage: "xmark") { dismiss() }
                .labelStyle(.iconOnly)
                .buttonStyle(.bordered)
                .buttonBorderShape(.circle)
                .padding(Theme.Spacing.medium)
        }
        .sensoryFeedback(.success, trigger: movie.persistentModelID)
    }
}

#Preview {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            ShuffleResultView(
                movie: Movie(title: "Blade Runner", genre: .scifi),
                onShuffleAgain: {},
                onMarkAsWatched: {}
            )
        }
}
