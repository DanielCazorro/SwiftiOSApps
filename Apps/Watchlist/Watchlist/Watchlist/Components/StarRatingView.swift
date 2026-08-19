//
//  StarRatingView.swift
//  Watchlist
//
//  Created by Daniel Cazorro on 19/08/2026.
//

import SwiftUI

/// Five-star rating. Read-only when `rating` is a constant binding.
struct StarRatingView: View {
    @Binding var rating: Int
    var isEditable: Bool = true

    private let maximum = 5

    var body: some View {
        HStack(spacing: Theme.Spacing.tight) {
            ForEach(1...maximum, id: \.self) { star in
                Image(systemName: star <= rating ? "star.fill" : "star")
                    .foregroundStyle(star <= rating ? AnyShapeStyle(Color.yellow.gradient) : AnyShapeStyle(.tertiary))
                    .contentTransition(.symbolEffect(.replace))
                    .onTapGesture {
                        guard isEditable else { return }
                        withAnimation(.snappy) {
                            // Tapping the current rating clears it, which is the
                            // only way to undo a rating without a second control.
                            rating = (rating == star) ? 0 : star
                        }
                    }
            }
        }
        .imageScale(.medium)
        // Read-only stars must let taps through to whatever contains them.
        .allowsHitTesting(isEditable)
        .sensoryFeedback(.selection, trigger: rating)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text("rating.label"))
        .accessibilityValue(Text("rating.value \(rating) \(maximum)"))
        .accessibilityAdjustableAction { direction in
            guard isEditable else { return }
            switch direction {
            case .increment: rating = min(rating + 1, maximum)
            case .decrement: rating = max(rating - 1, 0)
            @unknown default: break
            }
        }
    }
}

#Preview {
    @Previewable @State var rating = 3
    StarRatingView(rating: $rating)
        .padding()
}
