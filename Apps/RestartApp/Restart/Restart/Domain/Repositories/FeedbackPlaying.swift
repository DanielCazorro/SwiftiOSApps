//
//  FeedbackPlaying.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import Foundation

@MainActor
protocol FeedbackPlaying: AnyObject {
    func play(_ sound: SoundEffect)
    func vibrate(_ feedback: HapticFeedback)
    func prepare()
}
