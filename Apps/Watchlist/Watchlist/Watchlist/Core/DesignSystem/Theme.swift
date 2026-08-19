//
//  Theme.swift
//  Watchlist
//
//  Created by Daniel Cazorro on 19/08/2026.
//

import SwiftUI

/// Shared visual constants, so spacing and colours are decided once instead of
/// being re-invented (slightly differently) in every view.
enum Theme {
    /// The app's signature fill. Reads well on both light and dark backgrounds.
    static let brand: AnyGradient = Color.accentColor.gradient

    enum Spacing {
        static let tight: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 20
        static let extraLarge: CGFloat = 32
    }

    enum Radius {
        static let card: CGFloat = 20
    }

    /// Duration-free, feel-first animation used for every list mutation.
    static let listAnimation: Animation = .snappy(duration: 0.28)
}

extension Date {
    /// "Added 3 days ago" style text, resolved in the user's locale.
    var relativeDescription: String {
        formatted(.relative(presentation: .named))
    }
}
