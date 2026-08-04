//
//  GenerationStateTests.swift
//  HiyaTests
//
//  Created by Daniel Cazorro on 04/08/2026.
//

import Testing
@testable import Hiya

@Suite("Estado de generación")
struct GenerationStateTests {

    @Test("Solo hay texto mientras se responde o al terminar")
    func textOnlyWhenThereIsAnswer() {
        #expect(GenerationState.idle.text == nil)
        #expect(GenerationState.loading.text == nil)
        #expect(GenerationState.failed("boom").text == nil)

        #expect(GenerationState.responding("¡Hola").text == "¡Hola")
        #expect(GenerationState.finished("¡Hola!").text == "¡Hola!")
    }

    @Test("Está ocupado solo mientras carga o escribe")
    func isWorkingOnlyWhileBusy() {
        #expect(GenerationState.loading.isWorking)
        #expect(GenerationState.responding("a").isWorking)

        #expect(!GenerationState.idle.isWorking)
        #expect(!GenerationState.finished("a").isWorking)
        #expect(!GenerationState.failed("a").isWorking)
    }

    /// El bug original: el spinner no salía en la segunda pulsación porque la
    /// vista miraba si el texto estaba vacío en vez de mirar el estado.
    @Test("El spinner sale al pedir de nuevo, aunque ya hubiera respuesta")
    func spinnerShowsOnEveryRequest() {
        #expect(GenerationState.loading.isWaitingFirstToken)

        // Y no se queda pegado una vez llega la primera palabra.
        #expect(!GenerationState.responding("¡Hola").isWaitingFirstToken)
        #expect(!GenerationState.finished("¡Hola!").isWaitingFirstToken)
        #expect(!GenerationState.idle.isWaitingFirstToken)
    }

    /// El otro bug: animar con cada token superponía el texto viejo y el nuevo.
    @Test("La fase no cambia mientras solo llega más texto")
    func phaseIsStableWhileStreaming() {
        let start = GenerationState.responding("¡Ho")
        let more = GenerationState.responding("¡Hola, amigo!")

        #expect(start.phase == more.phase)
        #expect(start != more, "El estado sí cambia; lo que no cambia es la fase")
    }

    @Test("Cada tipo de estado tiene una fase distinta")
    func phasesAreUnique() {
        let phases = [
            GenerationState.idle,
            .loading,
            .responding("a"),
            .finished("a"),
            .failed("a")
        ].map(\.phase)

        #expect(Set(phases).count == phases.count)
    }
}
