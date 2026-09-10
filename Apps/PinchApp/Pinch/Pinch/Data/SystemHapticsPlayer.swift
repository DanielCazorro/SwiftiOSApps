//
//  SystemHapticsPlayer.swift
//  Pinch
//
//  Created by Daniel Cazorro on 10/09/2026.
//

import UIKit

@MainActor
final class SystemHapticsPlayer: HapticsPlaying {
    private let preferences: PreferencesRepository
    private let selection = UISelectionFeedbackGenerator()
    private let notification = UINotificationFeedbackGenerator()
    private let impact = UIImpactFeedbackGenerator(style: .rigid)

    init(preferences: PreferencesRepository) {
        self.preferences = preferences
    }

    func prepare() {
        selection.prepare()
        impact.prepare()
    }

    func play(_ feedback: HapticFeedback) {
        guard preferences.isHapticsEnabled else { return }
        switch feedback {
        case .selection:
            selection.selectionChanged()
        case .limit:
            impact.impactOccurred(intensity: 0.7)
        case .success:
            notification.notificationOccurred(.success)
        }
    }
}
