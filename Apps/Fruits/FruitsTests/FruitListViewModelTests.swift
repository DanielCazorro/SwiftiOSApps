//
//  FruitListViewModelTests.swift
//  FruitsTests
//
//  Created by Daniel Cazorro on 02/10/2026.
//

import Testing
@testable import Fruits

struct FruitListViewModelTests {
    @Test func containsEveryFruitExactlyOnce() {
        let repository = LocalFruitRepository()

        let viewModel = FruitListViewModel(repository: repository)

        #expect(viewModel.fruits.count == repository.fetchFruits().count)
        #expect(Set(viewModel.fruits.map(\.id)) == Set(repository.fetchFruits().map(\.id)))
    }

    @Test func startsWithSettingsHidden() {
        let viewModel = FruitListViewModel(repository: StubFruitRepository(fruits: []))

        #expect(viewModel.isShowingSettings == false)
    }
}
