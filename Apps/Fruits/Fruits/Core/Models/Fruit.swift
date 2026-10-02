//
//  Fruit.swift
//  Fruits
//
//  Created by Daniel Cazorro on 20/09/2026.
//

import SwiftUI

struct Fruit: Identifiable, Hashable {
    let id: String
    let image: ImageResource
    let lightColor: Color
    let darkColor: Color

    var title: String { localized("title") }
    var headline: String { localized("headline") }
    var description: String { localized("description") }

    var gradientColors: [Color] { [lightColor, darkColor] }

    func value(for nutrient: Nutrient) -> String {
        localized("nutrition.\(nutrient.rawValue)")
    }

    private func localized(_ field: String) -> String {
        let key = "\(id).\(field)"
        return String(localized: String.LocalizationValue(key), table: "FruitContent")
    }
}
