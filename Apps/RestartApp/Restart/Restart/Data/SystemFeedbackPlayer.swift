//
//  SystemFeedbackPlayer.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import AVFoundation
import OSLog
import UIKit

@MainActor
final class SystemFeedbackPlayer: FeedbackPlaying {
    private let preferences: PreferencesRepository
    private let logger = Logger(subsystem: "com.DanielCazorro.Restart", category: "Feedback")
    private var players: [SoundEffect: AVAudioPlayer] = [:]
    private let notificationGenerator = UINotificationFeedbackGenerator()
    private let selectionGenerator = UISelectionFeedbackGenerator()
    private let impactGenerator = UIImpactFeedbackGenerator(style: .soft)
    private var isSessionConfigured = false

    init(preferences: PreferencesRepository) {
        self.preferences = preferences
    }

    func prepare() {
        configureSessionIfNeeded()
        for effect in SoundEffect.allCases {
            _ = player(for: effect)
        }
        notificationGenerator.prepare()
        selectionGenerator.prepare()
        impactGenerator.prepare()
    }

    func play(_ sound: SoundEffect) {
        guard preferences.isSoundEnabled else { return }
        guard let player = player(for: sound) else { return }
        configureSessionIfNeeded()
        player.currentTime = 0
        player.play()
    }

    func vibrate(_ feedback: HapticFeedback) {
        switch feedback {
        case .success:
            notificationGenerator.notificationOccurred(.success)
        case .warning:
            notificationGenerator.notificationOccurred(.warning)
        case .selection:
            selectionGenerator.selectionChanged()
        case .impact:
            impactGenerator.impactOccurred()
        }
    }

    // MARK: - Helpers

    private func player(for sound: SoundEffect) -> AVAudioPlayer? {
        if let cached = players[sound] { return cached }
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: sound.fileExtension) else {
            logger.error("Missing sound file \(sound.rawValue, privacy: .public).\(sound.fileExtension, privacy: .public)")
            return nil
        }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            players[sound] = player
            return player
        } catch {
            logger.error("Could not load \(sound.rawValue, privacy: .public): \(error.localizedDescription, privacy: .public)")
            return nil
        }
    }

    private func configureSessionIfNeeded() {
        guard !isSessionConfigured else { return }
        isSessionConfigured = true
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.ambient, mode: .default, options: [.mixWithOthers])
            try session.setActive(true)
        } catch {
            logger.error("Could not configure the audio session: \(error.localizedDescription, privacy: .public)")
        }
    }
}
