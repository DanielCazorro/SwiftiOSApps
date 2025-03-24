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

    enum Destination: Identifiable {
        case home, navigationView, anotherView, itemListView, gridListView
        
        var id: Int {
            hashValue
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo con degradado
                LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.2), .purple.opacity(0.3)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    // Icono con animación
                    Image(systemName: "globe")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                        .scaleEffect(1.1)
                        .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: selectedDestination)

                    // Título principal
                    Text("Welcome to SwiftUI")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .shadow(radius: 5)

                    // Descripción
                    Text("Explore SwiftUI with a simple, elegant, and interactive interface.")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)

                    // Scroll horizontal con tarjetas informativas
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            InfoCard(icon: "star.fill", title: "Favorites")
                            InfoCard(icon: "person.fill", title: "Profile")
                            InfoCard(icon: "gearshape.fill", title: "Settings")
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()

                    // Botones de navegación con animaciones
                    VStack(spacing: 15) {
                        navigationButton(title: "Get Started", color: .blue) {
                            selectedDestination = .home
                        }
                        navigationButton(title: "Navigation View", color: .purple) {
                            selectedDestination = .navigationView
                        }
                        navigationButton(title: "Another View", color: .orange) {
                            selectedDestination = .anotherView
                        }
                        navigationButton(title: "List View", color: .green) {
                            selectedDestination = .itemListView
                        }
                        navigationButton(title: "Grid List", color: .cyan) {
                            selectedDestination = .gridListView
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 50)
                }
            }
            .navigationDestination(item: $selectedDestination) { destination in
                switch destination {
                case .home:
                    HomeView()
                case .navigationView:
                    CustomNavigationView()
                case .anotherView:
                    AnotherView()
                case .itemListView:
                    ItemListView()
                case .gridListView:
                    GridList()
                }
            }
            .overlay(
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

    // Componente para los botones de navegación
    @ViewBuilder
    private func navigationButton(title: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [color, color.opacity(0.7)]),
                                           startPoint: .leading,
                                           endPoint: .trailing))
                .cornerRadius(12)
                .shadow(radius: 5)
                .scaleEffect(1.0)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        action()
                    }
                }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ContentView()
}
