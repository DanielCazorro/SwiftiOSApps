//
//  FruitCardView.swift
//  Fruits
//
//  Created by Daniel Cazorro on 19/09/2026.
//

import SwiftUI

struct FruitCardView: View {
    // MARK: - Properties
    @State private var isAnimating = false

    var fruit: Fruit

    // MARK: - Body
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                // FRUIT: Image
                Image(fruit.image)
                    .resizable()
                    .scaledToFit()
                    .shadow(
                        color: Color(red: 0, green: 0, blue: 0, opacity: 0.15),
                        radius: 8,
                        x: 6,
                        y: 8)
                    .scaleEffect(isAnimating ? 1.0 : 0.6)

                // FRUIT: Title
                Text(fruit.title)
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .shadow(
                        color: Color(red: 0, green: 0, blue: 0, opacity: 0.15),
                        radius: 2,
                        x: 2,
                        y: 2)

                // FRUIT: Headline
                Text(fruit.headline)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: 480)

                // BUTTON: Start
                StartButtonView()

            } //: VStack
        } //: ZStack
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5)) {
                isAnimating = true
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(LinearGradient(
            gradient: Gradient(colors: fruit.gradientColors),
            startPoint: .top,
            endPoint: .bottom)
        )
        .cornerRadius(20)
        .padding(.horizontal, 20)
    }
}

#Preview {
    FruitCardView(fruit: fruitsData[2])
}
