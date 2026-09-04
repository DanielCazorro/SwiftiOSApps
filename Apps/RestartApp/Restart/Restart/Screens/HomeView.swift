//
//  HomeView.swift
//  Restart
//
//  Created by Daniel Cazorro on 01/09/2026.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Property
    @AppStorage("onboarding") var isOnboardingViewActive = false

    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            // MARK: - Header
            Spacer()

            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.1)

                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
            }

            // MARK: - Center
            Text("The time that leads to mastery is dependent on the intensity of our focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding()

            // MARK: - Footer
            Spacer()



            Button(action: {
                isOnboardingViewActive = true
            }) {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)

                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            } // : Button
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        } // Vstack
    }
}

#Preview {
    HomeView()
}
