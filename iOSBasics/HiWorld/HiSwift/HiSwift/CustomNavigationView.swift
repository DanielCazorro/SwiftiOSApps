//
//  CustomNavigationView.swift
//  HiSwift
//
//  Created by Daniel Cazorro Frías on 11/3/25.
//

import SwiftUI

struct CustomNavigationView: View {  // 🔴 Renombrada para evitar conflictos con NavigationView de SwiftUI
    @State private var show = false

    var body: some View {
        VStack {
            Button("Open Modal") {
                show.toggle()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .sheet(isPresented: $show) {
                ModalView()
            }
        }
    }
}

#Preview {
    CustomNavigationView()
}
