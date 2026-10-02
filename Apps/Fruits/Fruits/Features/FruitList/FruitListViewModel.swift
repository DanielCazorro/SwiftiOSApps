//
//  FruitListViewModel.swift
//  Fruits
//
//  Created by Daniel Cazorro on 02/10/2026.
//

import Observation

@Observable
final class FruitListViewModel {
    private(set) var fruits: [Fruit]
    var isShowingSettings = false

    init(repository: any FruitRepository = LocalFruitRepository()) {
        fruits = repository.fetchFruits().shuffled()
    }
}
