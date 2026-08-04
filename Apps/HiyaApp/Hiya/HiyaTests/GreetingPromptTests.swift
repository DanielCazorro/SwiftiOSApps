//
//  GreetingPromptTests.swift
//  HiyaTests
//
//  Created by Daniel Cazorro on 04/08/2026.
//

import Foundation
import Testing
@testable import Hiya

@Suite("Prompt de saludo")
struct GreetingPromptTests {

    // MARK: - Idioma

    @Test("Nombra el idioma al principio y al final", arguments: ResponseLanguage.allCases)
    func namesLanguageTwice(language: ResponseLanguage) {
        let prompt = GreetingPrompt(style: .fun, language: language)
        let name = language.promptName

        let mentions = prompt.text.components(separatedBy: name).count - 1

        // Con una sola mención el modelo se va al inglés en tonos marcados.
        #expect(mentions == 2, "El idioma \(name) debería aparecer dos veces")
    }

    @Test("Usa el nombre del idioma en inglés, no el traducido")
    func usesEnglishLanguageName() {
        let prompt = GreetingPrompt(style: .fun, language: .spanish)

        #expect(prompt.text.contains("Spanish"))
        #expect(!prompt.text.contains("Español"))
    }

    // MARK: - Tema

    @Test("Incluye el tema cuando hay texto")
    func includesTopic() {
        let prompt = GreetingPrompt(style: .fun, language: .spanish, topic: "el café")

        #expect(prompt.text.contains("Make it about: el café."))
    }

    @Test("Omite el tema si está vacío o solo tiene espacios",
          arguments: ["", "   ", "\n", " \n\t "])
    func omitsBlankTopic(topic: String) {
        let prompt = GreetingPrompt(style: .fun, language: .spanish, topic: topic)

        #expect(!prompt.text.contains("Make it about"))
    }

    @Test("Recorta los espacios del tema")
    func trimsTopic() {
        let prompt = GreetingPrompt(style: .fun, language: .spanish, topic: "  la playa  ")

        #expect(prompt.text.contains("Make it about: la playa."))
    }

    // MARK: - Emoji

    @Test("Pide emoji en los tonos alegres y lo prohíbe en los serios",
          arguments: AnswerStyle.allCases)
    func emojiMatchesStyle(style: AnswerStyle) {
        let text = GreetingPrompt(style: style, language: .spanish).text

        if style.usesEmoji {
            #expect(text.contains("Finish with one emoji"))
        } else {
            // Callarse no basta: si no se prohíbe, se cuelan igual.
            #expect(text.contains("Do not use any emoji."))
        }
    }

    // MARK: - Forma general

    @Test("Siempre menciona el tono elegido", arguments: AnswerStyle.allCases)
    func includesStyleDescription(style: AnswerStyle) {
        let prompt = GreetingPrompt(style: style, language: .spanish)

        #expect(prompt.text.contains(style.promptDescription))
    }

    @Test("Las instrucciones piden brevedad y nada de adornos")
    func instructionsAreStrict() {
        let instructions = GreetingPrompt.instructions

        #expect(instructions.contains("nothing else"))
        #expect(instructions.contains("under two sentences"))
    }
}
