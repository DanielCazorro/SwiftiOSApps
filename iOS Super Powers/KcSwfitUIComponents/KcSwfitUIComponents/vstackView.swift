//
//  vstackView.swift
//  KcSwfitUIComponents
//
//  Created by Daniel Cazorro Frías on 31/10/23.
//

import SwiftUI

struct vstackView: View {
    var body: some View {
        VStack{
            Text("Hola")
            Spacer()
            Text("Keepcoders")
            Spacer()
            Text("Esto es SwiftUI")
                .font(.caption)
        }
        // El orden de los factores afecta al producto (va por prioridad, de arriba hacia abajo)
        // Por lo tanto, dejar el background para el final
        .font(.largeTitle)
        .frame(width: 350, height: 350)
        .background(Color.blue)
        .foregroundColor(.white)
        // Por ejemplo, voy a modificar abajo y no va a variar nada
        .frame(width: 450, height: 450)
        .background(Color.yellow)
    }
}

#Preview {
    vstackView()
}
