//
//  ButtonView.swift
//  KcSwfitUIComponents
//
//  Created by Daniel Cazorro Frías on 31/10/23.
//

import SwiftUI

struct ButtonView: View {
    
    @State var imageChange = false
    
    
    var body: some View {
        VStack {
            
            switch imageChange {
            case true:
                // Imagen
                Image(systemName: "sun.max")
                    .resizable()
                    .foregroundColor(.yellow)
                    .frame(width: 200, height: 200)
                    .padding()
                
            case false:
                //Imagen
                Image(systemName: "cloud.drizzle")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 200, height: 200)
                    .padding()
            }
            
            
            // Botón
            Button(action: {
                // Acción here
                imageChange.toggle()
                
                
                
            }, label: {
                Text("Cambia el Tiempo")
                    .padding()
                    .foregroundColor(.white)
                    .background(.blue)
                    .font(.title)
                // .cornerRadius(20) // Hasta iOS15
                    .clipShape(RoundedRectangle(cornerRadius: 25))
            })
        }
    }
}

#Preview {
    ButtonView()
}
