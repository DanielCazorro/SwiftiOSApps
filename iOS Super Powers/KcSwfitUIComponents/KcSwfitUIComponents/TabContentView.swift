//
//  TabView.swift
//  KcSwfitUIComponents
//
//  Created by Daniel Cazorro Frías on 31/10/23.
//

import SwiftUI

struct TabContentView: View {
    var body: some View {
        TabView {
            ImageView()
                .tabItem {
                    Image(systemName: "star")
                    Text("Imagen")
                }
            
            ButtonView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Botones")
                }
        }
    }
}

#Preview {
    TabContentView()
}
