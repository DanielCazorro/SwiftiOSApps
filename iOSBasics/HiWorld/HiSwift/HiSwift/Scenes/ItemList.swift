//
//  ItemListView.swift
//  HiSwift
//
//  Created by Daniel Cazorro Frías on 17/3/25.
//

import SwiftUI

struct ItemListView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Fondo con degradado
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.8)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                // Lista con navegación
                List(itemList) { item in
                    NavigationLink(destination: ItemDetailView(item: item)) {
                        ItemRowView(item: item)
                    }
                    .listRowBackground(Color.clear)
                    .padding(.vertical, 5)
                }
                .background(Color.white.opacity(0.1)) // Fondo sutil detrás de la lista
                .cornerRadius(20)
                .padding()
                .scrollContentBackground(.hidden) // Oculta el fondo por defecto de la lista
            }
            .navigationTitle("Fruits List")
        }
    }
}

// MARK: - Item Row View
struct ItemRowView: View {
    let item: ItemModel

    var body: some View {
        HStack(spacing: 15) {
            Text(item.emoji)
                .font(.largeTitle)

            VStack(alignment: .leading, spacing: 5) {
                Text(item.name)
                    .font(.headline)
                    .foregroundColor(.white)

                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.2)) // Fondo translúcido para efecto glass
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5) // Sombra sutil
    }
}

// MARK: - Preview
#Preview {
    ItemListView()
}
