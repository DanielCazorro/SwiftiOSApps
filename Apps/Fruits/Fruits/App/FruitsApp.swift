//
//  FruitsApp.swift
//  Fruits
//
//  Created by Daniel Cazorro on 16/09/2026.
//

import SwiftUI

@main
struct FruitsApp: App {
    @State private var onboardingStore = OnboardingStore()

    var body: some Scene {
        WindowGroup {
            Group {
                if onboardingStore.isOnboarding {
                    OnboardingView()
                } else {
                    FruitListView()
                }
            }
            .environment(onboardingStore)
        }
    }
}
