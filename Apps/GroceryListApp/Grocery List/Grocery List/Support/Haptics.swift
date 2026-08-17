//
//  Haptics.swift
//  Grocery List
//
//  Created by Daniel Cazorro on 16/08/2026.
//

import SwiftUI

/// Thin wrapper over `.sensoryFeedback` so call sites read as intent, not as
/// a feedback type, and so the whole app can be muted from one place.
extension View {
    /// Fires when an item is ticked off or un-ticked.
    func completionFeedback(trigger: some Equatable) -> some View {
        sensoryFeedback(.impact(weight: .light), trigger: trigger)
    }

    /// Fires when the list is mutated (add / delete).
    func mutationFeedback(trigger: some Equatable) -> some View {
        sensoryFeedback(.selection, trigger: trigger)
    }
}
