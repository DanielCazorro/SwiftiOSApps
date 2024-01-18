//
//  KeyChain.swift
//  kcHerosClase
//
//  Created by Daniel Cazorro Frías on 6/11/23.
//

import KeychainSwift

// Guardamos

@discardableResult
func saveKC(key: String, value: String) -> Bool {
    // Conviertiendo cadena value en data con codificación utf8
    if let data = value.data(using: .utf8){
        return KeychainSwift().set(data, forKey: key)
    } else {
        // No desempaquete
        return false
    }
}

// Leemos del Keychain
func loadKC(key: String) -> String? {
    if let data = KeychainSwift().get(key) {
        return data
    } else {
        return ""
    }
}

// Borramos
func deleteKC(key: String) -> Bool {
    KeychainSwift().delete(key)
}
