//
//  hstackView.swift
//  KcSwfitUIComponents
//
//  Created by Daniel Cazorro Frías on 31/10/23.
//

import SwiftUI

struct hstackView: View {
    var body: some View {
        HStack{
            // Primer text
            Text("Mi nombre es:")
                .bold()
            
            // Segundo text
            Text("Daniel")
                .font(.title)
                .foregroundColor(.blue)
        }
        .frame(width: 300, height: 150)
        .background(Color.yellow)
        .cornerRadius(25)

    }
}

#Preview {
    hstackView()
}
