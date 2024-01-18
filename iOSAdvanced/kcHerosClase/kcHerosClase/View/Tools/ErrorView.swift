//
//  ErrorView.swift
//  kcHerosClase
//
//  Created by Daniel Cazorro Frías on 6/11/23.
//

import SwiftUI

struct ErrorView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    
    private var textError: String
    
    init(error: String) {
        self.textError = error
    }
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .foregroundStyle(.red)
                .frame(width: 200, height: 200)
                .padding()
                .id(0)
            
            Text("\(textError)")
                .font(.title2)
                .foregroundStyle(.red)
                .bold()
                .padding()
                .id(1)
            
            Spacer()
            
            // Boton
            Button(action: {
                // Acción
                rootViewModel.status = .none // Volvemos al login
                
            }, label: {
                Text("Return")
                    .font(.title)
                    .foregroundStyle(.white)
                    .frame(width: 300, height: 50)
                    .background(.orange)
                    .cornerRadius(15)
                    .shadow(radius: 10, x: 20, y: 10)
                    .id(2)
            })
            
        }
    }
}

#Preview {
    ErrorView(error: "ERROR TESTING")
        .environmentObject(RootViewModel())
}
