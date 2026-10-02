//
//  FruitRepositoryTests.swift
//  FruitsTests
//
//  Created by Daniel Cazorro on 02/10/2026.
//

import Testing
@testable import Fruits

struct FruitRepositoryTests {
    private let allFruits = LocalFruitRepository().fetchFruits()

    @Test func featuredFruitsKeepCatalogOrder() {
        let featured = LocalFruitRepository().fetchFeaturedFruits(limit: 6)

        #expect(featured.map(\.id) == allFruits.prefix(6).map(\.id))
    }

    @Test func featuredFruitsNeverExceedAvailableFruits() {
        let repository = StubFruitRepository(fruits: Array(allFruits.prefix(2)))

        #expect(repository.fetchFeaturedFruits(limit: 6).count == 2)
    }

    @Test func fruitIdentifiersAreUnique() {
        #expect(Set(allFruits.map(\.id)).count == allFruits.count)
    }
}

struct StubFruitRepository: FruitRepository {
    let fruits: [Fruit]

    func fetchFruits() -> [Fruit] {
        fruits
    }
}
