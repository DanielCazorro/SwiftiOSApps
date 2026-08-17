//
//  Theme.swift
//  Paws
//
//  Created by Daniel Cazorro on 17/08/2026.
//

import SwiftUI

// MARK: - Palette
//
// `Color.brandPrimary`, `.brandSecondary`, `.appBackground` and `.cardSurface`
// are generated automatically from the color sets in Assets.xcassets, so they
// stay in sync with the catalog (including their dark mode variants).

extension ShapeStyle where Self == LinearGradient {
    /// Warm gradient used behind the app and on empty photo placeholders.
    static var brandGradient: LinearGradient {
        LinearGradient(
            colors: [.brandPrimary.opacity(0.85), .brandSecondary.opacity(0.85)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

// MARK: - Layout constants

enum Metrics {
    static let cardCornerRadius: CGFloat = 22
    static let cardSpacing: CGFloat = 16
    static let cardMinWidth: CGFloat = 150
}

// MARK: - Reusable styles

/// Soft elevated surface shared by cards and detail sections.
struct CardBackground: ViewModifier {
    var cornerRadius: CGFloat = Metrics.cardCornerRadius

    func body(content: Content) -> some View {
        content
            .background(Color.cardSurface, in: .rect(cornerRadius: cornerRadius, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(.primary.opacity(0.06), lineWidth: 1)
            }
            .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)
    }
}

extension View {
    func cardBackground(cornerRadius: CGFloat = Metrics.cardCornerRadius) -> some View {
        modifier(CardBackground(cornerRadius: cornerRadius))
    }
}

/// Small pill used for species, breed and birthday information.
struct TagChip: View {
    var systemImage: String
    var title: String
    var tint: Color = .brandPrimary

    var body: some View {
        Label(title, systemImage: systemImage)
            .font(.caption.weight(.semibold))
            .lineLimit(1)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(tint.opacity(0.15), in: .capsule)
            .foregroundStyle(tint)
    }
}

#Preview {
    VStack(spacing: 20) {
        TagChip(systemImage: "dog.fill", title: "Dog")
        TagChip(systemImage: "birthday.cake.fill", title: "Today!", tint: .brandSecondary)
        Text(verbatim: "Card")
            .frame(width: 160, height: 100)
            .cardBackground()
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.appBackground)
}
