//
//  HapticsPlaying.swift
//  Pinch
//
//  Created by Daniel Cazorro on 10/09/2026.
//

@MainActor
protocol HapticsPlaying: AnyObject {
    func play(_ feedback: HapticFeedback)
    func prepare()
}
