//
//  AnotherView.swift
//  HiSwift
//
//  Created by Daniel Cazorro Frías on 12/3/25.
//

import SwiftUI

struct AnotherView: View {
    @State private var show = false
    @State private var text = ""

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.2), .purple.opacity(0.3)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(spacing: 25) {
                    Spacer()
                    
                    Text("Bienvenido a Another View")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(radius: 5)

                    TextField("Introduce un texto...", text: $text)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .padding(.horizontal)

                    NavigationLink(destination: ModalView(text: text)) {
                        HStack {
                            Image(systemName: "arrow.right.circle.fill")
                            Text("Ir a la Segunda Vista")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Another View")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ContentView()) {
                        Image(systemName: "house.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                    
                    NavigationLink(destination: ModalView(text: text)) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.green)
                    }
                }
            }
        }
    }
}

#Preview {
    AnotherView()
}
