//
//  FruitListView.swift
//  Fruits
//
//  Created by Daniel Cazorro on 16/09/2026.
//

import SwiftUI

struct FruitListView: View {
    @State private var viewModel = FruitListViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.fruits) { fruit in
                NavigationLink(value: fruit) {
                    FruitRowView(fruit: fruit)
                        .padding(.vertical, 4)
                }
            }
            .navigationTitle("Fruits")
            .navigationDestination(for: Fruit.self) { fruit in
                FruitDetailView(fruit: fruit)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Settings", systemImage: "slider.horizontal.3") {
                        viewModel.isShowingSettings = true
                    }
                }
            }
            .sheet(isPresented: $viewModel.isShowingSettings) {
                SettingsView()
            }
        }
    }
}

#Preview {
    FruitListView()
        .environment(OnboardingStore())
}
