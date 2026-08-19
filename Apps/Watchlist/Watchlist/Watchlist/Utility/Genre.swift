//
//  Genre.swift
//  Watchlist
//
//  Created by Daniel Cazorro on 18/08/2026.
//

import Foundation

enum Genre: Int, Codable, CaseIterable, Identifiable {
    var id: Int {
        rawValue
    }

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
}

extension Genre {
    var name: String {
        switch self {
            case .action:
                "Action"
            case .comedy:
                "Comedy"
            case .crime:
                "Crime"
            case .documentary:
                "Documentary"
            case .drama:
                "Drama"
            case .fantasy:
                "Fantasy"
            case .kids:
                "Kids"
            case .musical:
                "Musical"
            case .scifi:
                "Science Fiction"
            case .romance:
                "Romance"
            case .thriller:
                "Thriller"
            case .western:
                "Western"
        }
    }
}
