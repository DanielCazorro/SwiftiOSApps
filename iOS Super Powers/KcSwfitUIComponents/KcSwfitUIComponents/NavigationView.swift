//
//  NavigationView.swift
//  KcSwfitUIComponents
//
//  Created by Daniel Cazorro Frías on 31/10/23.
//

import SwiftUI

struct NavigationView: View {
    
    // Array de heroes
    let heros = [
    Hero(name: "Thor"),
    Hero(name: "Spiderman"),
    Hero(name: "Capitan América")
    ]
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(heros) { hero in
                    NavigationLink {
                        // Destination
                        HeroDetailView(data: hero)
                    } label: {
                        // Celda
                        HStack {
                            Image(systemName: "person")
                            Text(hero.name)
                        }
                    }
                }
            }
            .navigationTitle("Heros")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Filtrar datos"){}
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Filtrar datos"){}
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Filtrar datos"){}
                }
            }
            
        }
    }
}

#Preview {
    NavigationView()
}
