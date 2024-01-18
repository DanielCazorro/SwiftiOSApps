//
//  DetailModalView.swift
//  KcSwfitUIComponents
//
//  Created by Daniel Cazorro Frías on 31/10/23.
//

import SwiftUI

struct DetailModalView: View {
    
    // Referencia a memoria de una variable booleana
    @Binding var showDetail: Bool
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack {
            Text("Soy el modal...")
            
            Button(action: {
                // Poner a false
                // showDetail.toggle()
                
                presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Text("Cerrar el modal")
                    .padding()
                    .foregroundColor(.white)
                    .background(.red)
                    .cornerRadius(20)
            })
        }
    }
}

/*
#Preview {
    DetailModalView()
}
*/
