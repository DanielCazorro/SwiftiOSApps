//
//  Feedback.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import Foundation

enum SoundEffect: String, CaseIterable, Sendable {
    case unlock = "chimeup"
    case restart = "success"

    var fileExtension: String {
        switch self {
        case .unlock: "mp3"
        case .restart: "m4a"
        }
    }
}

enum HapticFeedback: Sendable {
    case success
    case warning
    case selection
    case impact
}
