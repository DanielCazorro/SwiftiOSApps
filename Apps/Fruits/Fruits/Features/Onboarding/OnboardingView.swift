//
//  OnboardingView.swift
//  Fruits
//
//  Created by Daniel Cazorro on 19/09/2026.
//

import SwiftUI

struct OnboardingView: View {
    var fruits: [Fruit] = LocalFruitRepository().fetchFeaturedFruits()

    var body: some View {
        TabView {
            ForEach(fruits) { fruit in
                FruitCardView(fruit: fruit)
            }
        }
        .tabViewStyle(.page)
        .padding(.vertical, 20)
    }
}

#Preview {
    OnboardingView()
        .environment(OnboardingStore())
}
