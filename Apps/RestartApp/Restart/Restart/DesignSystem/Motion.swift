//
//  Motion.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import SwiftUI

enum Motion {
    static func entrance(reduceMotion: Bool, delay: Double = 0) -> Animation? {
        reduceMotion ? nil : .easeOut(duration: 0.8).delay(delay)
    }

    static func interactive(reduceMotion: Bool) -> Animation? {
        reduceMotion ? nil : .spring(response: 0.45, dampingFraction: 0.75)
    }

    static func float(reduceMotion: Bool) -> Animation? {
        reduceMotion ? nil : .easeInOut(duration: 4).repeatForever(autoreverses: true)
    }
}
