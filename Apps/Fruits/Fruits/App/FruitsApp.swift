//
//  FruitsApp.swift
//  Fruits
//
//  Created by Daniel Cazorro on 16/09/2026.
//

import SwiftUI

@main
struct FruitsApp: App {
    // MARK: - Properties
    @AppStorage("isOnboarding") private var isOnboarding = true

    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnboardingView()
            }
            else {
                ContentView()
            }
        }
    }
}
