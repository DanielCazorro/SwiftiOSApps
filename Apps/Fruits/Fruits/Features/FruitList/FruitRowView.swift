//
//  FruitRowView.swift
//  Fruits
//
//  Created by Daniel Cazorro on 27/09/2026.
//

import SwiftUI

struct FruitRowView: View {
    let fruit: Fruit

    var body: some View {
        HStack {
            Image(fruit.image)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .shadow(color: .black.opacity(0.3), radius: 3, x: 2, y: 2)
                .background(
                    LinearGradient(colors: fruit.gradientColors, startPoint: .top, endPoint: .bottom)
                        .clipShape(.rect(cornerRadius: 8))
                )
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 5) {
                Text(fruit.title)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(fruit.headline)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .accessibilityElement(children: .combine)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    FruitRowView(fruit: .sample)
        .padding()
}
