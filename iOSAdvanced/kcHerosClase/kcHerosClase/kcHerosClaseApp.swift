//
//  kcHerosClaseApp.swift
//  kcHerosClase
//
//  Created by Daniel Cazorro Frías on 6/11/23.
//

import SwiftUI

@main
struct kcHerosClaseApp: App {
    let persistenceController = PersistenceController.shared // Core Data
    
    // ViewModel global
    @StateObject var rootViewModel = RootViewModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(rootViewModel)
        }
    }
}
