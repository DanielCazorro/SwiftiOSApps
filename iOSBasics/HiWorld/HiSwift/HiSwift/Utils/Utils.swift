//
//  Utils.swift
//  HiSwift
//
//  Created by Daniel Cazorro Frías on 2/3/25.
//

import SwiftUI

// Componente para tarjetas de información
struct InfoCard: View {
    var icon: String
    var title: String

    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(.blue)
                .padding()
                .background(Circle().fill(Color.blue.opacity(0.2)))
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .frame(width: 120, height: 140)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(.init(top: 8, leading: 0, bottom: 8, trailing: 0))
    }
}

// Botón flotante con alerta
struct FloatingButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
        .padding(20)
    }
}
