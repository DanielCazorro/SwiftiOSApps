//
//  GridList.swift
//  HiSwift
//
//  Created by Daniel Cazorro Frías on 24/3/25.
//

import SwiftUI

struct GridList: View {
    let adaptiveGrid = [GridItem(.adaptive(minimum: 80), spacing: 16)]
    let fixedGrid = [GridItem(.fixed(100)), GridItem(.fixed(100))]
    let flexibleGrid = [GridItem(.flexible(minimum: 30, maximum: 100))]
    let secondGridItem: [GridItem] = Array(repeating: .init(.flexible(minimum: 30, maximum: 100)), count: 3)
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
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

#Preview {
    GridList()
}
