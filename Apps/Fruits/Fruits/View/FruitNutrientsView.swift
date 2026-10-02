//
//  FruitNutrientsView.swift
//  Fruits
//
//  Created by Daniel Cazorro on 29/09/2026.
//

import SwiftUI

struct FruitNutrientsView: View {
    var fruit: Fruit
    let nutrients: [String] = ["Energy", "Sugar", "Fat", "Protein", "Vitamins", "Minerals"]

    var body: some View {
        GroupBox() {
            DisclosureGroup("Nutritional value per 100g") {
                ForEach(0..<nutrients.count, id: \.self) { item in
                    Divider().padding(.vertical, 2)

                    HStack {
                        Group {
                            Image(systemName: "info.circle")
                            Text(nutrients[item])
                        }
                        .foregroundStyle(fruit.gradientColors[1])
                        .font(.system(.body).bold())

                        Spacer(minLength: 25)
                        Text(fruit.nutrition[item])
                            .multilineTextAlignment(.trailing)
                    }
                }
            } // Disclosure Group
        }
    }
}

#Preview {
    FruitNutrientsView(fruit: fruitsData[0])
        .preferredColorScheme(.dark)
}
