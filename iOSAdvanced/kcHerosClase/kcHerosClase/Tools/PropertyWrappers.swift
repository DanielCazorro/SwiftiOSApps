//
//  PropertyWrappers.swift
//  kcHerosClase
//
//  Created by Daniel Cazorro Frías on 6/11/23.
//

import Foundation

// Persistencia en KeyChain

@propertyWrapper
class kcPersistenceKeychain {
    private var key: String
    
    init(key: String) {
        self.key = key
    }
    
    var wrappedValue: String {
        // Leen tu propiedad
        get {
            if let value = loadKC(key: key){
                return value
            } else {
                return ""
            }
        }
        
        // Te asignan valor
        set {
            // Grabar
            saveKC(key: key, value: newValue)
        }
    }
}
