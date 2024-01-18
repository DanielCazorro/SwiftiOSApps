//
//  ImageView.swift
//  KcSwfitUIComponents
//
//  Created by Daniel Cazorro Frías on 31/10/23.
//

import SwiftUI

struct ImageView: View {
    var body: some View {
        VStack{
            Image(systemName: "house")
                .resizable()
                .frame(width: 200, height: 200)
            
            Divider()
            
            // Imagen asíncrona...
            AsyncImage(url: URL(string: "https://www.monsterhunter.com/world/sp/images/top/bg_mv.jpg")) { Image in
                Image
                    .resizable()
                
            } placeholder: {
                ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(4)
            }
            .frame(width: 150, height: 200)
            
            Divider()
            
            Image(decorative: "linterna")
                .resizable()
                .frame(width: 200, height: 200)
                .cornerRadius(25)
            
        }
    }
}

#Preview {
    ImageView()
}
