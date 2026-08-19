//
//  GenreBadge.swift
//  Watchlist
//
//  Created by Daniel Cazorro on 19/08/2026.
//

import SwiftUI

/// Compact, colour-coded label for a genre.
struct GenreBadge: View {
    let genre: Genre
    var showsLabel: Bool = true

    var body: some View {
        Label {
            if showsLabel {
                Text(genre.name)
            }
        } icon: {
            Image(systemName: genre.symbolName)
                .imageScale(.small)
        }
        .font(.caption.weight(.semibold))
        .foregroundStyle(genre.tint)
        .padding(.horizontal, showsLabel ? Theme.Spacing.small : Theme.Spacing.tight)
        .padding(.vertical, Theme.Spacing.tight)
        .background(genre.tint.opacity(0.12), in: .capsule)
        // The icon already carries the colour, so the label alone is enough for
        // VoiceOver — reading "capsule, image" would just be noise.
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text(genre.name))
    }
}

#Preview {
    VStack(alignment: .leading, spacing: Theme.Spacing.small) {
        ForEach(Genre.allCases) { genre in
            GenreBadge(genre: genre)
        }
    }
    .padding()
}
