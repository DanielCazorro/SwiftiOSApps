//
//  GridList.swift
//  HiSwift
//
//  Created by Daniel Cazorro Frías on 24/3/25.
//

import SwiftUI

struct GridList: View {
    // Binding: Es la conexión entre una propiedad que almacena datos (variable) y una vista que cambia el valor (Textfield)
    
    let adaptiveGrid = [GridItem(.adaptive(minimum: 80), spacing: 16)]
    let fixedGrid = [GridItem(.fixed(100)), GridItem(.fixed(100))]
    let flexibleGrid = [GridItem(.flexible(minimum: 30, maximum: 100))]
    let secondGridItem: [GridItem] = Array(repeating: .init(.flexible(minimum: 30, maximum: 100)), count: 3)
    @State private var show = true
    @State private var number = 0
    @State private var title = "Título"
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    Text(title)
                        .font(.largeTitle)
                    Button(action: {
                        withAnimation {
                            show.toggle()
                            if show {
                                number -= 1
                            } else {
                                number += 1
                            }
                        }
                    }) {
                        Text(show ? "Ocultar ❤️" : "Mostrar ❤️")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(show ? Color.red : Color.green)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 5)
                            .font(.headline)
                    }
                    .padding(.horizontal)
                    
                    if show {
                        Image(systemName: "heart")
                            .foregroundStyle(.red)
                            .font(.largeTitle)
                    } else {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                            .font(.largeTitle)
                    }
                    Text(String(number))
                        .bold()
                    VStack(spacing: 24) {
                        Text("Emoji Grid")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        
                        // Sección Grid Adaptable
                        Text("🔹 Adaptive Grid")
                            .font(.headline)
                            .foregroundColor(.white)
                        LazyVGrid(columns: adaptiveGrid, spacing: 16) {
                            ForEach(itemList) { item in
                                GridItemView(item: item)
                            }
                        }
                        
                        Divider().background(Color.white.opacity(0.5))
                        
                        // Sección Grid Fijo
                        Text("🔹 Fixed Grid")
                            .font(.headline)
                            .foregroundColor(.white)
                        LazyVGrid(columns: fixedGrid, spacing: 16) {
                            ForEach(itemList) { item in
                                GridItemView(item: item)
                            }
                        }
                        
                        Divider().background(Color.white.opacity(0.5))
                        
                        // Sección Grid Flexible
                        Text("🔹 Flexible Grid")
                            .font(.headline)
                            .foregroundColor(.white)
                        LazyHGrid(rows: flexibleGrid, spacing: 16) {
                            ForEach(itemList) { item in
                                GridItemView(item: item)
                            }
                        }
                        
                        Divider().background(Color.white.opacity(0.5))
                        
                        // Sección Grid Flexible con Múltiples Filas
                        Text("🔹 Multi-Row Flexible Grid")
                            .font(.headline)
                            .foregroundColor(.white)
                        LazyHGrid(rows: secondGridItem, spacing: 16) {
                            ForEach(itemList) { item in
                                GridItemView(item: item)
                            }
                        }
                    }
                    .padding()
                }
                .background(
                    LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all))
                .navigationTitle("Grids")
            }
        }
        VStack(alignment: .leading, spacing: 20) {
            Text("Editor de título")
                .font(.title2)
                .bold()
                .foregroundColor(.orange)
            
            TextField("Escribe un título...", text: $title)
                .padding()
                .background(Color.orange.opacity(0.2))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.orange, lineWidth: 1)
                )
                .shadow(radius: 2)

            Text("Título actual: \(title)")
                .foregroundColor(.orange)
                .font(.subheadline)

            GridTitleView(title: $title)
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all))
        .navigationTitle("Grids")
    }
    
}

struct GridItemView: View {
    let item: ItemModel
    
    var body: some View {
        Text(item.emoji)
            .font(.system(size: 30))
            .frame(width: 80, height: 80)
            .background(Color.white.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .black.opacity(0.3), radius: 5, x: 2, y: 2)
            .padding(4)
    }
}

struct GridTitleView: View {
    @Binding var title: String
    var body: some View {
        VStack(spacing: 12) {
            Text("Vista secundaria")
                .font(.headline)
                .foregroundStyle(.red)
            Text("Título compartido: \(title)")
                .font(.title2)
                .foregroundStyle(.white)
                .padding()
                .background(Color.red.opacity(0.2))
                .cornerRadius(10)
        }
    }
}

#Preview {
    GridList()
}
