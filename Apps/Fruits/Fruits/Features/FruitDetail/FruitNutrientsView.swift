//
//  FruitNutrientsView.swift
//  Fruits
//
//  Created by Daniel Cazorro on 29/09/2026.
//

import SwiftUI

struct FruitNutrientsView: View {
    let fruit: Fruit

    var body: some View {
        GroupBox {
            DisclosureGroup("Nutritional value per 100 g") {
                ForEach(Nutrient.allCases) { nutrient in
                    Divider()
                        .padding(.vertical, 2)

                    HStack {
                        Label {
                            Text(nutrient.name)
                        } icon: {
                            Image(systemName: "info.circle")
                        }
                        .foregroundStyle(fruit.darkColor)
                        .font(.body.bold())

                        Spacer(minLength: 25)

                        Text(fruit.value(for: nutrient))
                            .multilineTextAlignment(.trailing)
                    }
                    .accessibilityElement(children: .combine)
                }
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    FruitNutrientsView(fruit: .sample)
        .padding()
        .preferredColorScheme(.dark)
}
