//
//  AnswerStyle.swift
//  Hiya
//
//  Created by Daniel Cazorro on 04/08/2026.
//

import Foundation

/// Tono con el que la IA escribe el saludo.
enum AnswerStyle: String, CaseIterable, Identifiable {
    case fun
    case poetic
    case formal
    case pirate
    case joke
    case motivational

    var id: Self { self }

    /// Texto visible en la UI (se traduce desde el catálogo de strings).
    var title: LocalizedStringResource {
        switch self {
        case .fun: "Fun"
        case .poetic: "Poetic"
        case .formal: "Formal"
        case .pirate: "Pirate"
        case .joke: "Joke"
        case .motivational: "Motivational"
        }
    }

    var symbol: String {
        switch self {
        case .fun: "party.popper.fill"
        case .poetic: "text.quote"
        case .formal: "briefcase.fill"
        case .pirate: "sailboat.fill"
        case .joke: "theatermasks.fill"
        case .motivational: "flame.fill"
        }
    }

    /// Si el saludo debe rematarse con un emoji. Los tonos serios van sin él.
    var usesEmoji: Bool {
        switch self {
        case .fun, .pirate, .joke, .motivational: true
        case .poetic, .formal: false
        }
    }

    /// Descripción que viaja dentro del prompt. Se mantiene en inglés a propósito:
    /// el modelo del sistema sigue mejor las instrucciones en ese idioma.
    var promptDescription: String {
        switch self {
        case .fun: "playful, warm and full of energy"
        case .poetic: "lyrical and poetic, with a vivid image"
        case .formal: "polite, elegant and professional"
        case .pirate: "like an old sea pirate, with nautical slang"
        case .joke: "built around a light, silly pun"
        case .motivational: "encouraging, like a short pep talk"
        }
    }
}
