//
//  FruitRepository.swift
//  Fruits
//
//  Created by Daniel Cazorro on 02/10/2026.
//

protocol FruitRepository {
    func fetchFruits() -> [Fruit]
}

extension FruitRepository {
    func fetchFeaturedFruits(limit: Int = 6) -> [Fruit] {
        Array(fetchFruits().prefix(limit))
    }
}
