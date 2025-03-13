//
//  ModalView.swift
//  HiSwift
//
//  Created by Daniel Cazorro Frías on 11/3/25.
//

import SwiftUI

struct ModalView: View {
    @Environment(\.presentationMode) var back
    var text: String

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.orange, .red]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text(text)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button(action: {
                    back.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "xmark.circle.fill")
                        Text("Cerrar")
                    }
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.9))
                    .foregroundColor(.black)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                }
                .padding(.horizontal, 30)
            }
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(20)
            .shadow(radius: 10)
            .padding(30)
            .transition(.scale)
        }
    }
}

#Preview {
    ModalView(text: "Ventana Modal")
}
