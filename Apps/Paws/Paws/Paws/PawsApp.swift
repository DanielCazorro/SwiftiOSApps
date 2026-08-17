//
//  PawsApp.swift
//  Paws
//
//  Created by Daniel Cazorro on 17/08/2026.
//

import SwiftUI
import SwiftData

@main
struct PawsApp: App {
    var body: some Scene {
        WindowGroup {
            PetListView()
                .tint(.brandPrimary)
        }
        .modelContainer(for: Pet.self)
    }
}
