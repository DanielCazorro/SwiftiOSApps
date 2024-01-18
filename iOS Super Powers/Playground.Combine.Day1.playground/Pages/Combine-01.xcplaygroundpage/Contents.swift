//: [Previous](@previous)

import UIKit
import Combine

// MARK: - Publicadores


// Ejemplo 1. Array de enteros

print("------------------------------------------")
print("Ejercicio 1. Array enteros. SINK")
print("------------------------------------------")


let publisher1 = [1,2,3,4].publisher

publisher1.sink { data in
    // Aquí llega el dato al suscriptor...
    print("Ejercicio 1. Llega dato... \(data)")
}


print("------------------------------------------")
print("Ejercicio 2. Array enteros. SINK y Completion")
print("------------------------------------------")

publisher1.sink { completion in
    switch completion {
    case .failure(let error):
        //Error
        print("Error \(error)")
    case .finished:
        //Success
        print("Ejecutado success")
    }
} receiveValue: { data in
    print("Ejercicio 2. Llega dato... \(data)")
}




//: [Next](@next)
