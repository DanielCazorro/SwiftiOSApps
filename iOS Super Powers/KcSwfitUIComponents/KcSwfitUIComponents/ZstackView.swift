//
//  ZstackView.swift
//  KcSwfitUIComponents
//
//  Created by Daniel Cazorro Frías on 31/10/23.
//

import SwiftUI

struct ZstackView: View {
    var body: some View {
        ZStack {
            // Imagen linterna verde
            Image(decorative: "linterna")
                .resizable()
                .frame(width: 200, height: 200)
                .cornerRadius(25)
            
            // Capa oscura transparente
            Image(decorative: "")
                .resizable()
                .background(.black)
                .frame(width: 200, height: 200)
                .cornerRadius(25)
                .opacity(0.3)

                // Título
                Text("Linterna Verde")
                    .font(.title)
                    .foregroundStyle(.white)
            
        }
    }
}

#Preview {
    ZstackView()
}
