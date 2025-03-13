//
//  TabView.swift
//  HiSwift
//
//  Created by Daniel Cazorro Frías on 13/3/25.
//

import SwiftUI

struct TabViewMain: View {
    var body: some View {
        TabView {
            ContentView().tabItem {
                Label("Home", systemImage: "house.fill")
            }
            AnotherView().tabItem {
                Label("Another", systemImage: "plus.circle")
            }
            CustomNavigationView().tabItem {
                Label("Custom", systemImage: "folder.fill")
            }
            HomeView().tabItem {
                Label("Home?", systemImage: "house")
            }
            ModalView(text: "Daniel").tabItem {
                Label("Modal", systemImage: "plus.circle")
            }
        }
    }
}

#Preview {
    TabViewMain()
}
