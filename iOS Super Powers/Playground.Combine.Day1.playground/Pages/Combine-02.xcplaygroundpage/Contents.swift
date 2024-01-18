//: [Previous](@previous)

import Foundation
import Combine

// MARK: - Suscriptores. Almacenamos el suscriptor -


// MARK: - Ejercicio 1. Almacenamos el suscriptor en una constante


print("------------------------------------------")
print("Ejercicio 1. Guardamos el suscritpor")
print("------------------------------------------")

let publisher2 = [1,2,3,4].publisher

let suscriptor2 = publisher2.sink { data in
    print("Ejercicio1: recibo \(data)")
}

let suscriptor1 : AnyCancellable?

suscriptor1 = publisher2.sink { data in
    print("Ejercicio1: recibo \(data)")
}

// suscriptor1.cancel() // Cancelo suscriptor


print("------------------------------------------")
print("Ejercicio 2. Guardamos el suscritpor Store")
print("------------------------------------------")

var suscriptor3 = Set<AnyCancellable>()

publisher2.sink { data in
    print("Ejercicio 2-1: recibo \(data)")
}
.store(in: &suscriptor3)

publisher2.sink { data in
    print("Ejercicio 2-2: recibo \(data)")
}
.store(in: &suscriptor3)


print("------------------------------------------")
print("Ejercicio 3. ¿Cómo lo hacemos en un ViewModel?")
print("------------------------------------------")

class viewModel {
    var valor: String = "" {
        didSet {
            print("Ejercicio 3 - Valor asignado: \(valor)")
        }
    }
    
    // Definir un publicador
    var publisher = ["Hola", "Keepcoders"].publisher
    
    // Set de suscriptores
    var suscribers = Set<AnyCancellable>()
    
    init(){
        /*
         // El suscriptor recibe el valor del publicador
         publisher.sink { data in
         self.valor = data // Asigno el valor
         }
         .store(in: &suscribers)
         */
        
        publisher
            .assign(to: \.valor, on: self) // Mi clase la propiedad valor
            .store(in: &suscribers)
    }
}

// Lanzo

let vm = viewModel()


//: [Next](@next)
