//
//  PinchApp.swift
//  Pinch
//
//  Created by Daniel Cazorro on 08/09/2026.
//

import SwiftUI

@main
struct PinchApp: App {
    private let dependencies = AppDependencies()

    var body: some Scene {
        WindowGroup {
            ViewerView(dependencies: dependencies)
                .task { dependencies.haptics.prepare() }
        }
    }
}
