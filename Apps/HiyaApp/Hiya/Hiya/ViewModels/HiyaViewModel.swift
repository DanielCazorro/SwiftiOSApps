//
//  HiyaViewModel.swift
//  Hiya
//
//  Created by Daniel Cazorro on 04/08/2026.
//

import Foundation
import FoundationModels
import Observation

/// Toda la conversación con el modelo del sistema vive aquí; las vistas solo
/// leen `state` y las opciones.
@MainActor
@Observable
final class HiyaViewModel {

    // MARK: - Opciones que controla el usuario

    var style: AnswerStyle = .fun
    var language: ResponseLanguage = .preferred
    /// Tema opcional sobre el que girará el saludo.
    var topic: String = ""
    /// Temperatura del modelo: 0 = predecible, 2 = muy creativo.
    var creativity: Double = 1.0

    // MARK: - Estado

    private(set) var state: GenerationState = .idle

    // MARK: - Dependencias

    private let model = SystemLanguageModel.default
    private var session: LanguageModelSession
    private var generation: Task<Void, Never>?

    init() {
        session = LanguageModelSession(instructions: GreetingPrompt.instructions)
    }

    // MARK: - Disponibilidad

    var availability: SystemLanguageModel.Availability { model.availability }
    var isAvailable: Bool { model.isAvailable }
    var canGenerate: Bool { isAvailable && !state.isWorking }

    /// Adelanta la carga del modelo para que la primera respuesta llegue antes.
    func prepare() {
        guard isAvailable else { return }
        session.prewarm()
    }

    // MARK: - Acciones

    func generate() {
        guard isAvailable else { return }
        generation?.cancel()
        generation = Task { [weak self] in await self?.run() }
    }

    /// Corta la generación en curso conservando lo que ya se había escrito.
    func cancel() {
        generation?.cancel()
        generation = nil
        if let partial = state.text, !partial.isEmpty {
            state = .finished(partial)
        } else {
            state = .idle
        }
        // La sesión se quedó a medias: se descarta para no arrastrar ese
        // saludo incompleto al contexto del siguiente.
        newSession()
    }

    func clear() {
        generation?.cancel()
        generation = nil
        topic = ""
        state = .idle
        newSession()
    }

    // MARK: - Generación

    private func run() async {
        state = .loading

        let options = GenerationOptions(temperature: creativity)
        var partial = ""

        do {
            let stream = session.streamResponse(to: prompt.text, options: options)
            for try await snapshot in stream {
                partial = snapshot.content
                state = .responding(partial)
            }
            try Task.checkCancellation()
            state = .finished(partial)
        } catch is CancellationError {
            // El usuario paró: `cancel()` ya dejó el estado como toca.
            return
        } catch {
            state = .failed(error.localizedDescription)
        }

        generation = nil
        // Cada saludo empieza de cero: así el contexto no crece sin control
        // y la sesión nueva queda precalentada para la siguiente pulsación.
        newSession()
    }

    /// Las opciones actuales empaquetadas como prompt.
    var prompt: GreetingPrompt {
        GreetingPrompt(style: style, language: language, topic: topic)
    }

    private func newSession() {
        session = LanguageModelSession(instructions: GreetingPrompt.instructions)
        session.prewarm()
    }
}
