//
//  ContentView.swift
//  ViewBuilder
//
//  Created by Daniel Cazorro Frías on 7/11/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    private var esmujer = true
    
    
    var body: some View {
        VStack {
            Text("Color Hombre / Mujer")
                .font(.title)
                .if(esmujer) { Text in
                    // Transformación
                    Text
                        .foregroundStyle(.orange)
                        .font(.title2)
                }
                .if(!esmujer) { Text in
                    // Transformacion
                    Text
                        .foregroundStyle(.blue)
                        .font(.caption)
                }
            /*
             .if(colorScheme == .dark) { View in
             View.background(.yellow)
             } */
                .background(colorScheme == .light ? Color.gray : Color.yellow)
            
            
            // Boton
           KcButton {
                Button(action: {
                    // Action
                }, label: {
                    Text("Login")
                })
           }
            KcButton {
                 Button(action: {
                     // Action
                 }, label: {
                     Text("Change Pass")
                 })
            }
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
