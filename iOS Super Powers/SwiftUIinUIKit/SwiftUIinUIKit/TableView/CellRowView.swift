//
//  CellRowView.swift
//  SwiftUIinUIKit
//
//  Created by Daniel Cazorro Frías on 8/11/23.
//

import SwiftUI

struct CellRowView: View {
    var numero: Int // El modelo
    
    var body: some View {
        Spacer()
        VStack{
            Image(systemName: "number.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundStyle(.blue)
                .padding()
            HStack{
                Spacer()
                Text("Número \(numero)")
                    .font(.title)
                Spacer()
            }
            Spacer()
        }
        .background(.orange)
    }
}

struct CellRowView_Previews: PreviewProvider {
    static var previews: some View {
        CellRowView(numero: 2)
            .previewLayout(.fixed(width: 400.0, height: 200.0))
        
    }
}
