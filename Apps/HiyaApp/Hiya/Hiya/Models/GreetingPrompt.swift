//
//  GreetingPrompt.swift
//  Hiya
//
//  Created by Daniel Cazorro on 04/08/2026.
//

import Foundation

/// El texto que se le manda al modelo, construido a partir de las opciones.
///
/// Es un valor puro —sin sesión, sin red, sin estado— para poder comprobarlo
/// en los tests sin depender de Apple Intelligence.
struct GreetingPrompt: Equatable {
    var style: AnswerStyle
    var language: ResponseLanguage
    var topic: String = ""

    /// Reglas fijas de la sesión: se mandan una sola vez, así cada petición
    /// puede ser corta.
    static let instructions = """
    You write short greetings for the user of an app called Hiya.
    Always answer with the greeting itself and nothing else: no quotes, \
    no preamble, no explanation of what you did.
    Keep it under two sentences.
    Every request names a language: write the greeting in that language and \
    in no other, whatever the requested tone may be.
    """

    /// El tema, ya limpio de espacios sobrantes.
    var trimmedTopic: String {
        topic.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// El prompt final.
    ///
    /// El idioma se nombra al principio y al final a propósito: un tono muy
    /// marcado (el pirata, por ejemplo) arrastra al modelo hacia el inglés si
    /// la instrucción aparece una sola vez y en medio.
    var text: String {
        let target = language.promptName

        var lines = [
            "Write a greeting in \(target).",
            "Tone: \(style.promptDescription)."
        ]

        if !trimmedTopic.isEmpty {
            lines.append("Make it about: \(trimmedTopic).")
        }

        // Permitir los emoji no basta: el modelo solo los pone si se le manda
        // explícitamente. Y hay que prohibirlos igual de explícitamente en los
        // tonos serios, o se cuelan.
        lines.append(style.usesEmoji
                     ? "Finish with one emoji that fits the greeting."
                     : "Do not use any emoji.")

        lines.append("Write every single word in \(target).")

        return lines.joined(separator: "\n")
    }
}
