//
//  ResponseLanguage.swift
//  Hiya
//
//  Created by Daniel Cazorro on 04/08/2026.
//

import Foundation

/// Idioma en el que la IA debe responder.
enum ResponseLanguage: String, CaseIterable, Identifiable {
    case spanish = "es"
    case english = "en"
    case french = "fr"
    case german = "de"
    case italian = "it"
    case portuguese = "pt"

    var id: Self { self }

    /// El idioma del sistema si está soportado; si no, inglés.
    static var preferred: ResponseLanguage {
        guard let code = Locale.current.language.languageCode?.identifier else { return .english }
        return ResponseLanguage(rawValue: code) ?? .english
    }

    var flag: String {
        switch self {
        case .spanish: "🇪🇸"
        case .english: "🇬🇧"
        case .french: "🇫🇷"
        case .german: "🇩🇪"
        case .italian: "🇮🇹"
        case .portuguese: "🇵🇹"
        }
    }

    /// Nombre del idioma traducido al idioma del usuario. Lo da el sistema, así que
    /// no hace falta traducirlo a mano.
    var displayName: String {
        Locale.current.localizedString(forLanguageCode: rawValue)?.localizedCapitalized ?? rawValue
    }

    /// Nombre en inglés, para insertarlo en el prompt.
    var promptName: String {
        Locale(identifier: "en_US").localizedString(forLanguageCode: rawValue) ?? rawValue
    }
}
