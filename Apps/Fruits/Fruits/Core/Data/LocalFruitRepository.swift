//
//  LocalFruitRepository.swift
//  Fruits
//
//  Created by Daniel Cazorro on 20/09/2026.
//

import SwiftUI

struct LocalFruitRepository: FruitRepository {
    func fetchFruits() -> [Fruit] {
        Self.fruits
    }

    private static let fruits: [Fruit] = [
        Fruit(id: "blueberry", image: .blueberry, lightColor: .colorBlueberryLight, darkColor: .colorBlueberryDark),
        Fruit(id: "strawberry", image: .strawberry, lightColor: .colorStrawberryLight, darkColor: .colorStrawberryDark),
        Fruit(id: "lemon", image: .lemon, lightColor: .colorLemonLight, darkColor: .colorLemonDark),
        Fruit(id: "plum", image: .plum, lightColor: .colorPlumLight, darkColor: .colorPlumDark),
        Fruit(id: "lime", image: .lime, lightColor: .colorLimeLight, darkColor: .colorLimeDark),
        Fruit(id: "pomegranate", image: .pomegranate, lightColor: .colorPomegranateLight, darkColor: .colorPomegranateDark),
        Fruit(id: "pear", image: .pear, lightColor: .colorPearLight, darkColor: .colorPearDark),
        Fruit(id: "gooseberry", image: .gooseberry, lightColor: .colorGooseberryLight, darkColor: .colorGooseberryDark),
        Fruit(id: "mango", image: .mango, lightColor: .colorMangoLight, darkColor: .colorMangoDark),
        Fruit(id: "watermelon", image: .watermelon, lightColor: .colorWatermelonLight, darkColor: .colorWatermelonDark),
        Fruit(id: "cherry", image: .cherry, lightColor: .colorCherryLight, darkColor: .colorCherryDark),
        Fruit(id: "grapefruit", image: .grapefruit, lightColor: .colorGrapefruitLight, darkColor: .colorGrapefruitDark),
        Fruit(id: "apple", image: .apple, lightColor: .colorAppleLight, darkColor: .colorAppleDark)
    ]
}

#if DEBUG
extension Fruit {
    static let sample = LocalFruitRepository().fetchFruits()[0]
}
#endif
