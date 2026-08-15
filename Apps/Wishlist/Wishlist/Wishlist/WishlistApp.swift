//
//  WishlistApp.swift
//  Wishlist
//
//  Created by Daniel Cazorro on 15/08/2026.
//

import SwiftUI
import SwiftData

@main
struct WishlistApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Wish.self)
        }
    }
}
