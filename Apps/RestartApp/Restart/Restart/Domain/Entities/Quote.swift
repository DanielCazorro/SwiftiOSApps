//
//  Quote.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import Foundation

struct Quote: Identifiable, Hashable, Sendable {
    let id: String
    let textKey: String
    let authorKey: String
}
