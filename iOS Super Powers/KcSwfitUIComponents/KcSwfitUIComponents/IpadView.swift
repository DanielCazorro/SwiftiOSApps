//
//  IpadView.swift
//  KcSwfitUIComponents
//
//  Created by Daniel Cazorro Frías on 31/10/23.
//

import SwiftUI

struct IpadView: View {
    @State private var heros = ["Goku","Krillin","Vegeta","Son Gohan"]
    @State private var selectedHero: String?
    
    var body: some View {
        NavigationSplitView {
            List(heros, id: \.self, selection: $selectedHero, rowContent: Text.init)
                .navigationSplitViewColumnWidth(500)
        } detail: {
            // Detalle
            
            Text(selectedHero ?? "Selecciona un Heroe")
        }

    }
}

#Preview {
    IpadView()
}
