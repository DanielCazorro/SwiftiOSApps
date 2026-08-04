//
//  GenerationState.swift
//  Hiya
//
//  Created by Daniel Cazorro on 04/08/2026.
//

import Foundation

/// Estados por los que pasa una petición a la IA.
/// Tener un único `enum` en vez de varios booleanos evita estados imposibles
/// (por ejemplo "cargando" y "con error" a la vez) y hace que la vista sea
/// una función directa del estado.
enum GenerationState: Equatable {
    /// Todavía no se ha pedido nada.
    case idle
    /// Petición enviada, esperando la primera palabra.
    case loading
    /// Llegando texto poco a poco (streaming).
    case responding(String)
    /// Respuesta completa.
    case finished(String)
    /// Algo falló.
    case failed(String)

    /// Texto a mostrar, si lo hay.
    var text: String? {
        switch self {
        case .responding(let text), .finished(let text): text
        case .idle, .loading, .failed: nil
        }
    }

    /// `true` mientras la IA está trabajando.
    var isWorking: Bool {
        switch self {
        case .loading, .responding: true
        case .idle, .finished, .failed: false
        }
    }

    /// `true` solo antes de recibir la primera palabra: es cuando toca el spinner.
    var isWaitingFirstToken: Bool { self == .loading }

    /// Identifica el "tipo" de estado, ignorando el texto.
    /// Sirve para animar los cambios de pantalla (hueco → spinner → texto) sin
    /// re-animar la vista con cada palabra que llega por streaming, que es lo
    /// que provoca que se vea el texto viejo y el nuevo superpuestos.
    var phase: Int {
        switch self {
        case .idle: 0
        case .loading: 1
        case .responding: 2
        case .finished: 3
        case .failed: 4
        }
    }
}
