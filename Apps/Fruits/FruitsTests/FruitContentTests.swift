//
//  FruitContentTests.swift
//  FruitsTests
//
//  Created by Daniel Cazorro on 02/10/2026.
//

import Foundation
import Testing
import UIKit
@testable import Fruits

struct FruitContentTests {
    private let fruits = LocalFruitRepository().fetchFruits()

    @Test func everyFruitHasAnImage() {
        for fruit in fruits {
            #expect(UIImage(named: fruit.id) != nil, "Missing image for \(fruit.id)")
        }
    }

    @Test func fruitResolvesItsLocalizedContent() {
        for fruit in fruits {
            #expect(fruit.title != "\(fruit.id).title")
            #expect(fruit.headline != "\(fruit.id).headline")
            #expect(fruit.description != "\(fruit.id).description")
            for nutrient in Nutrient.allCases {
                #expect(fruit.value(for: nutrient) != "\(fruit.id).nutrition.\(nutrient.rawValue)")
            }
        }
    }

    @Test(arguments: ["en", "es"])
    func everyFruitIsFullyTranslated(language: String) throws {
        let path = try #require(Bundle.main.path(forResource: language, ofType: "lproj"))
        let bundle = try #require(Bundle(path: path))
        let fields = ["title", "headline", "description"] + Nutrient.allCases.map { "nutrition.\($0.rawValue)" }

        for fruit in fruits {
            for field in fields {
                let key = "\(fruit.id).\(field)"
                #expect(bundle.localizedString(forKey: key, value: nil, table: "FruitContent") != key)
            }
        }
    }
}
