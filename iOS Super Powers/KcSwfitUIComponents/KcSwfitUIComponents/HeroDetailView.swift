//
//  HeroDetailView.swift
//  KcSwfitUIComponents
//
//  Created by Daniel Cazorro Frías on 31/10/23.
//
struct Hero: Identifiable {
    let id: UUID = UUID()
    let name: String
}

import SwiftUI

struct HeroDetailView: View {
    
    var data: Hero
    
    var body: some View {
        VStack {
            Text("Soy \(data.name)")
        }
        .navigationTitle("Hero Detail")
    }
}

#Preview {
    HeroDetailView(data: Hero(name: "Capitan américa"))
}
