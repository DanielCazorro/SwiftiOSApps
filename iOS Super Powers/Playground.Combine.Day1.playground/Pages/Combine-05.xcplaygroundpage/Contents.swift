//: [Previous](@previous)

import Foundation
import Combine

// MARK: - Notification center -

// Para qeu funcione NotificationCenter aquí...
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true


// Nuestra propia notificacion
extension Notification.Name{
    static let myNotification = Notification.Name("Keepcoding-Clase-Combine")
}

// Creamos una propiedad de mensaje, donde almacenamos los mensajes que llegan de NotificationCenter
var message: String = "" {
    didSet {
        print("Nuevo valor: \(message)")
    }
}

// Me creo un publicador
let publisher = NotificationCenter.default.publisher(for: .myNotification)

    .map{
        $0.object as? String // Convierto a cadena el tipo Object
    }

    .replaceNil(with: "No llega nada")
    .replaceError(with: "Hay error")
    .replaceEmpty(with: "Viene vacío")

var subscriber: AnyCancellable?

subscriber = publisher.sink(receiveValue: {
    message = $0
})


// Emito por NotificationCenter

let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
    // Lo que quieres hacer cada 3 segundos
    // NotificationCenter.default.post(name: .myNotification, object: "Mensaje \(Int.random(in: 1...50))")
    // NotificationCenter.default.post(name: .myNotification, object: nil)
}


//: [Next](@next)
