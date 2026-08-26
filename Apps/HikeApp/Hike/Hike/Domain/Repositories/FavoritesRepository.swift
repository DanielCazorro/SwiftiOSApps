//
//  FavoritesRepository.swift
//  Hike
//
//  Created by Daniel Cazorro on 24/08/2026.
//

import Foundation

protocol FavoritesRepository: Sendable {
    func favoriteHikeIDs() -> Set<Hike.ID>
    func setFavorite(_ isFavorite: Bool, forHikeID id: Hike.ID)
}
