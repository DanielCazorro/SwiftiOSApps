//: [Previous](@previous)

import Foundation

//MARK: - KVO. Observadores de propiedad -

// Ejemplo de observador de propiedad sencillo con Swift

var name = "" {
    willSet {
        print("Nuevo valor futuro -> \(newValue)")
        // keychain -> Borrar
    }
    
    didSet {
        print("Nuevo valor asignado -> \(name)")
    }
}

name = "Luis"


// MARK: - KVO en OBJ-C. Observador fuera de la propiedad

@objc class Person: NSObject {
    @objc dynamic var name = "Taylor Swift"
}

let taylor = Person()

// Creamos el observador

taylor.observe(\Person.name, options: .new) { person, change in
    print("Ahora cambia el nombre a ... \(person.name)")
}

taylor.name = "Jose"
taylor.name = "Manolo"


//: [Next](@next)
