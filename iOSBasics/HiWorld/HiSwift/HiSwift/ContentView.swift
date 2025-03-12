//
//  ContentView.swift
//  HiSwift
//
//  Created by Daniel Cazorro Frías on 24/2/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingAlert = false
    @State private var selectedDestination: Destination? = nil // Estado para la navegación

    enum Destination {
        case home
        case navigationView
        case anotherView
    }

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

                // Botón que navega a HomeView
                Button(action: {
                    selectedDestination = .home
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

                // Botón que navega a NavigationView
                Button(action: {
                    selectedDestination = .navigationView
                }) {
                    Text("Navigation View")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 20)
                
                // Botón que navega a AnotherView
                Button(action: {
                    selectedDestination = .anotherView
                }) {
                    Text("Another View")
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
            .navigationDestination(item: $selectedDestination) { destination in
                switch destination {
                case .home:
                    HomeView()
                case .navigationView:
                    CustomNavigationView()
                case .anotherView:
                    AnotherView()
                }
            }
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
        }
    }
}

#Preview {
    ContentView()
}
