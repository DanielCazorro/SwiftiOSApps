//
//  ItemDetailView.swift
//  HiSwift
//
//  Created by Daniel Cazorro Frías on 18/3/25.
//

import SwiftUI

struct ItemDetailView: View {
    var item: ItemModel
    @Environment(\.dismiss) var dismiss // Permite cerrar la vista si es presentada como modal

    var body: some View {
        ZStack {
            // Fondo con degradado
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.8)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                // Emoji grande
                Text(item.emoji)
                    .font(.system(size: 100))
                    .shadow(radius: 5)

                // Tarjeta con información
                VStack(spacing: 10) {
                    Text(item.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text(item.description)
                        .font(.title2)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)

                // Botón para cerrar la vista
                Button(action: {
                    dismiss()
                }) {
                    Text("Close")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.8))
                        .cornerRadius(15)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 40)
            }
            .padding()
        }
    }
}

// MARK: - Preview
#Preview {
    ItemDetailView(item: ItemModel(emoji: "⭐️", name: "Star", description: "A bright shining star."))
}
