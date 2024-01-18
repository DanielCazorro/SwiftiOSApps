//
//  Listas01View.swift
//  KcSwfitUIComponents
//
//  Created by Daniel Cazorro Frías on 31/10/23.
//

import SwiftUI

struct Listas01View: View {
    
    let heros = ["Thor","Spiderman", "Capitán América"]
    
    @State var heroSelected: String = "" // Guardo el Heroe seleccionado
    @State private var showAlert = false // Para que salte el alert
    
    var body: some View {
        
        List {
            ForEach(heros, id: \.self){ data in
                // Pinto lo que quiero que sea la celda
                Button(action: {
                    heroSelected = data // Guardo el Heroe tap
                    showAlert = true
                }, label: {
                    Text(data)
                })
            }
        }
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("El heroe seleccionado es \(heroSelected)"))
        })
        
        
        /*
        List {
            Text("Thor")
            Text("Spiderman")
            Text("Captain ")
        }
        */
        
        
    }
}

#Preview {
    Listas01View()
}
