//
//  UserDefaultsFavoritesRepository.swift
//  Hike
//
//  Created by Daniel Cazorro on 24/08/2026.
//

import Foundation

struct UserDefaultsFavoritesRepository: FavoritesRepository {
    nonisolated(unsafe) private let defaults: UserDefaults
    private let storageKey: String

    init(defaults: UserDefaults = .standard, storageKey: String = "favoriteHikeIDs") {
        self.defaults = defaults
        self.storageKey = storageKey
    }

    func favoriteHikeIDs() -> Set<Hike.ID> {
        let stored = defaults.array(forKey: storageKey) as? [Int] ?? []
        return Set(stored)
    }

    func setFavorite(_ isFavorite: Bool, forHikeID id: Hike.ID) {
        var ids = favoriteHikeIDs()
        if isFavorite {
            ids.insert(id)
        } else {
            ids.remove(id)
        }
        defaults.set(Array(ids).sorted(), forKey: storageKey)
    }
}
