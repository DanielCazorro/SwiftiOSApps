//
//  LoaderView.swift
//  kcHerosClase
//
//  Created by Daniel Cazorro Frías on 6/11/23.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        
        Image(systemName: "clock")
            .resizable()
            .frame(width: 150, height: 150)
        
        Text("Por favor espere")
            .font(.title)
            .padding(.top, 50)
    }
}

#Preview {
    LoaderView()
}
