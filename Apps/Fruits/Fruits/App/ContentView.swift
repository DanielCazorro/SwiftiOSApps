//
//  ContentView.swift
//  Fruits
//
//  Created by Daniel Cazorro on 16/09/2026.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State private var isShowingSettings = false

    var fruits: [Fruit] = fruitsData

    // MARK: - Body
    var body: some View {
        NavigationView {
            List {
                ForEach(fruits.shuffled()) { item in
                    NavigationLink(destination: FruitDetailView(fruit: item)) {
                        FruitRowView(fruit: item)
                            .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Fruits")
            .navigationBarItems(trailing: Button(action: {
                isShowingSettings = true
            }) {
                Image(systemName: "slider.horizontal.3")
            } // Button
                .sheet(isPresented: $isShowingSettings, content: {
                    SettingsView()
                })
            )
        } // Navigation
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView(fruits: fruitsData)
}
