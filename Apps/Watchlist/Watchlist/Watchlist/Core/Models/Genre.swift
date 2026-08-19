//
//  Genre.swift
//  Watchlist
//
//  Created by Daniel Cazorro on 18/08/2026.
//

import SwiftUI

/// Movie genres.
///
/// The raw value is what gets persisted, so the numbers are part of the storage
/// contract: never renumber an existing case, only append new ones at the end.
enum Genre: Int, Codable, CaseIterable, Identifiable, Sendable {
    case action = 1
    case comedy
    case crime
    case documentary
    case drama
    case fantasy
    case kids
    case musical
    case scifi
    case romance
    case thriller
    case western

    var id: Int { rawValue }
}

// MARK: - Presentation

extension Genre {
    var name: LocalizedStringResource {
        switch self {
        case .action: "genre.action"
        case .comedy: "genre.comedy"
        case .crime: "genre.crime"
        case .documentary: "genre.documentary"
        case .drama: "genre.drama"
        case .fantasy: "genre.fantasy"
        case .kids: "genre.kids"
        case .musical: "genre.musical"
        case .scifi: "genre.scifi"
        case .romance: "genre.romance"
        case .thriller: "genre.thriller"
        case .western: "genre.western"
        }
    }

    var symbolName: String {
        switch self {
        case .action: "flame"
        case .comedy: "theatermasks"
        case .crime: "handcuffs"
        case .documentary: "text.book.closed"
        case .drama: "drop"
        case .fantasy: "wand.and.sparkles"
        case .kids: "teddybear"
        case .musical: "music.note"
        case .scifi: "atom"
        case .romance: "heart"
        case .thriller: "eye.trianglebadge.exclamationmark"
        case .western: "hat.cap"
        }
    }

    var tint: Color {
        switch self {
        case .action: .red
        case .comedy: .orange
        case .crime: .brown
        case .documentary: .teal
        case .drama: .indigo
        case .fantasy: .purple
        case .kids: .mint
        case .musical: .pink
        case .scifi: .cyan
        case .romance: Color(red: 0.85, green: 0.28, blue: 0.45)
        case .thriller: Color(red: 0.35, green: 0.35, blue: 0.45)
        case .western: Color(red: 0.72, green: 0.55, blue: 0.20)
        }
    }
}
