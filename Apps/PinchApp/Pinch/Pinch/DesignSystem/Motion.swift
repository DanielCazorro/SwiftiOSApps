//
//  Motion.swift
//  Pinch
//
//  Created by Daniel Cazorro on 10/09/2026.
//

import SwiftUI

enum Motion {
    static func entrance(reduceMotion: Bool) -> Animation? {
        reduceMotion ? nil : .easeOut(duration: 0.6)
    }

    static func zoom(reduceMotion: Bool) -> Animation? {
        reduceMotion ? nil : .spring(response: 0.35, dampingFraction: 0.8)
    }

    static func drawer(reduceMotion: Bool) -> Animation? {
        reduceMotion ? nil : .spring(response: 0.4, dampingFraction: 0.85)
    }

    static func pageChange(reduceMotion: Bool) -> Animation? {
        reduceMotion ? .none : .easeInOut(duration: 0.3)
    }
}
