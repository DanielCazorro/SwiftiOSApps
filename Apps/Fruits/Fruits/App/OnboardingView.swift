//
//  OnboardingView.swift
//  Fruits
//
//  Created by Daniel Cazorro on 19/09/2026.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - Properties
    var fruits: [Fruit] = fruitsData

    // MARK: - Body
    var body: some View {
        TabView {
            ForEach(fruits[0...5]) { item in
                FruitCardView(fruit: item)
            } // Loop
        } // Tab
        .tabViewStyle(PageTabViewStyle())
        .padding(.vertical, 20)
    }
}

#Preview {
    OnboardingView()
}
