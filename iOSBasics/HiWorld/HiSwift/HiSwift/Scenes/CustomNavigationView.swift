//
//  CustomNavigationView.swift
//  HiSwift
//
//  Created by Daniel Cazorro Frías on 11/3/25.
//

import SwiftUI

struct CustomNavigationView: View {
    @State private var show = false
    @State private var text: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.2), .purple.opacity(0.3)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack(spacing: 25) {
                    Spacer()
                    
                    Text("Introduce un texto:")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(radius: 5)

                    TextField("Escribe algo aquí...", text: $text)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .padding(.horizontal)

                    Button(action: {
                        withAnimation {
                            show.toggle()
                        }
                    }) {
                        HStack {
                            Image(systemName: "arrow.up.right.circle.fill")
                            Text("Abrir Modal")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                                   startPoint: .leading,
                                                   endPoint: .trailing))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                    .padding(.horizontal)

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Custom Navigation")
            .sheet(isPresented: $show) {
                ModalView(text: text)
            }
        }
    }
}

#Preview {
    CustomNavigationView()
}
