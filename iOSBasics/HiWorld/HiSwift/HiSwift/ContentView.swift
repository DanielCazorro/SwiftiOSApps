//
//  ContentView.swift
//  HiSwift
//
//  Created by Daniel Cazorro Frías on 24/2/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingAlert = false
    @State private var isNavigating = false // Estado para la navegación manual

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Icono principal
                Image(systemName: "globe")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding(.top, 20)

                // Título
                Text("Welcome to SwiftUI")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                // Descripción
                Text("Explore the world of SwiftUI with this simple but elegant interface.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)

                // Scroll horizontal con listas
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        InfoCard(icon: "star.fill", title: "Favorites")
                        InfoCard(icon: "person.fill", title: "Profile")
                        InfoCard(icon: "gearshape.fill", title: "Settings")
                    }
                    .padding(.horizontal)
                }
                Spacer()

                // Botón normal que activa la navegación
                Button(action: {
                    isNavigating = true
                }) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 80)

            }
            .padding(.bottom, 20)
            .overlay(
                // Botón flotante que muestra una alerta
                FloatingButton {
                    isShowingAlert = true
                }
                .alert(isPresented: $isShowingAlert) {
                    Alert(title: Text("Floating Button"),
                          message: Text("This is a floating button action."),
                          dismissButton: .default(Text("OK")))
                },
                alignment: .bottomTrailing
            )
            .navigationDestination(isPresented: $isNavigating) {
                HomeView()
            }
        }
    }
}

#Preview {
    ContentView()
}
