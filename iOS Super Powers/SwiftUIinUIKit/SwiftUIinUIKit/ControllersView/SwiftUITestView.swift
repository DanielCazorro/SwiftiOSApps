//
//  SwiftUITestView.swift
//  SwiftUIinUIKit
//
//  Created by Daniel Cazorro Frías on 8/11/23.
//

import SwiftUI

struct SwiftUITestView: View {
    var body: some View {
        VStack{
            Spacer()
            Image(systemName: "person")
                .resizable()
                .frame(width: 200, height: 200)
            
            HStack{
                
                Text("Hola mundo")
                    .bold()
            }
            Spacer()
        }
    }
}

#Preview {
    SwiftUITestView()
}
