//
//  HerosModel.swift
//  kcHerosClase
//
//  Created by Daniel Cazorro Frías on 6/11/23.
//

import Foundation


struct Heros: Codable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var photo: String // Es una URL
    var favorite: Bool? // El usuario conectado marca como favorito un heroe
    
    
    func getFullName() -> String {
        return "\(name)"
    }
    
}

// Para la request, necesito enviar el nombre del heroe

struct HerosFilter: Codable {
    var name: String
}
