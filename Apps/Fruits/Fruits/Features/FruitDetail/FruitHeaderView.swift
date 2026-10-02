//
//  FruitHeaderView.swift
//  Fruits
//
//  Created by Daniel Cazorro on 28/09/2026.
//

import SwiftUI

struct FruitHeaderView: View {
    let fruit: Fruit

    var body: some View {
        ZStack {
            LinearGradient(colors: fruit.gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing)

            Image(fruit.image)
                .resizable()
                .scaledToFit()
                .fruitImageShadow()
                .padding(.vertical, 20)
                .scaleInOnAppear()
                .accessibilityHidden(true)
        }
        .frame(height: 440)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    FruitHeaderView(fruit: .sample)
}
