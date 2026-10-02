//
//  FruitDetailView.swift
//  Fruits
//
//  Created by Daniel Cazorro on 28/09/2026.
//

import SwiftUI

struct FruitDetailView: View {
    var fruit: Fruit

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 20) {
                    // Header
                    FruitHeaderView(fruit: fruit)

                    VStack(alignment: .leading, spacing: 20) {
                        // Title
                        Text(fruit.title)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundStyle(fruit.gradientColors[1])

                        // Headline
                        Text(fruit.headline)
                            .font(.headline)
                            .multilineTextAlignment(.leading)

                        // Nutrients
                        FruitNutrientsView(fruit: fruit)

                        // Subheadline
                        Text("Learn more about \(fruit.title)".uppercased())
                            .fontWeight(.bold)
                            .foregroundStyle(fruit.gradientColors[1])

                        // Description
                        Text(fruit.description)
                            .multilineTextAlignment(.leading)

                        // Link
                        SourceLinkView()
                            .padding(.top, 10)
                            .padding(.bottom, 40)

                    } // VStack
                    .padding(.horizontal, 20)
                    .frame(maxWidth: 640, alignment: .center)
                } // VStack
            } // Scroll
            .edgesIgnoringSafeArea(.top)
        } // Navigation
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    FruitDetailView(fruit: fruitsData[0])
}
