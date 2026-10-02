//
//  FruitDetailView.swift
//  Fruits
//
//  Created by Daniel Cazorro on 28/09/2026.
//

import SwiftUI

struct FruitDetailView: View {
    let fruit: Fruit

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                FruitHeaderView(fruit: fruit)

                VStack(alignment: .leading, spacing: 20) {
                    Text(fruit.title)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundStyle(fruit.darkColor)
                        .accessibilityAddTraits(.isHeader)

                    Text(fruit.headline)
                        .font(.headline)

                    FruitNutrientsView(fruit: fruit)

                    Text("Learn more about \(fruit.title)")
                        .fontWeight(.bold)
                        .textCase(.uppercase)
                        .foregroundStyle(fruit.darkColor)
                        .accessibilityAddTraits(.isHeader)

                    Text(fruit.description)

                    SourceLinkView()
                        .padding(.top, 10)
                        .padding(.bottom, 40)
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: 640)
            }
        }
        .scrollIndicators(.hidden)
        .ignoresSafeArea(edges: .top)
        .toolbarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        FruitDetailView(fruit: .sample)
    }
}
