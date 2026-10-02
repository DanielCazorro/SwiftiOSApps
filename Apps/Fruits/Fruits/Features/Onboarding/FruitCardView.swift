//
//  FruitCardView.swift
//  Fruits
//
//  Created by Daniel Cazorro on 19/09/2026.
//

import SwiftUI

struct FruitCardView: View {
    let fruit: Fruit

    var body: some View {
        VStack(spacing: 20) {
            Image(fruit.image)
                .resizable()
                .scaledToFit()
                .fruitImageShadow()
                .scaleInOnAppear()
                .accessibilityHidden(true)

            Text(fruit.title)
                .foregroundStyle(.white)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .shadow(color: .black.opacity(0.15), radius: 2, x: 2, y: 2)
                .accessibilityAddTraits(.isHeader)

            Text(fruit.headline)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .frame(maxWidth: 480)

            StartButtonView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: fruit.gradientColors, startPoint: .top, endPoint: .bottom))
        .clipShape(.rect(cornerRadius: 20))
        .padding(.horizontal, 20)
    }
}

#Preview {
    FruitCardView(fruit: .sample)
        .environment(OnboardingStore())
}
