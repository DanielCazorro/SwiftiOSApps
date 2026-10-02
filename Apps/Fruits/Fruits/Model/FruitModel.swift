//
//  FruitModel.swift
//  Fruits
//
//  Created by Daniel Cazorro on 20/09/2026.
//

import SwiftUI

// MARK: - Fruits data model
struct Fruit: Identifiable {
    var id = UUID()
    var title: String
    var headline: String
    var image: String
    var gradientColors: [Color]
    var description: String
    var nutrition: [String]
}
