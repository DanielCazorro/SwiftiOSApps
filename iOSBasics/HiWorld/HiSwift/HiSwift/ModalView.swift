//
//  ModalView.swift
//  HiSwift
//
//  Created by Daniel Cazorro Frías on 11/3/25.
//

import SwiftUI

struct ModalView: View {
    @Environment(\.presentationMode) var back

    var body: some View {
        ZStack {
            Color.orange.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Modal Window")
                    .font(.title)
                    .foregroundStyle(.white)
                    .bold()
                
                Button("Close") {
                    back.wrappedValue.dismiss()
                }
                .padding()
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(8)
            }
        }
    }
}

#Preview {
    ModalView()
}
