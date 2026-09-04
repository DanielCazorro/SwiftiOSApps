//
//  OnboardingView.swift
//  Restart
//
//  Created by Daniel Cazorro on 01/09/2026.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - Prroperty
    @AppStorage("onboarding") var isOnboardingViewActive = true

    // MARK: - Body
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)

            VStack(spacing: 20) {
                // MARK: - Header
                Spacer()

                VStack(spacing: 0) {
                    Text("Share.")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundStyle(.white)

                    Text("""
                        It's not how much we give but
                        how much love we put into giving 
                        """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                } //: Header

                // MARK: - Center
                ZStack {
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)

                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                }// : Center
                Spacer()

                // MARK: - Footer
                ZStack {
                    // Parts of the custom  button

                    // 1. Backgorund (static)
                    Capsule()
                        .fill(Color.white.opacity(0.2))

                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)

                    // 2. Call to action (static)
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .offset(x: 20)

                    // 3. Capsule (Dynamic width)
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: 80)

                        Spacer()
                    }

                    // 4. Circle (Draggable)
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.blue.opacity(0.15))
                                .padding()
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundStyle(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .onTapGesture {
                            isOnboardingViewActive = false
                        }

                        Spacer()
                    } // HStack
                } // Footer
                .frame(height: 80, alignment: .center)
                .padding()
            } //: VStack
        } // ZStack
    }
}

#Preview {
    OnboardingView()
}
