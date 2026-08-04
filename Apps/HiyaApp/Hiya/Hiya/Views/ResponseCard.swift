//
//  ResponseCard.swift
//  Hiya
//
//  Created by Daniel Cazorro on 04/08/2026.
//

import SwiftUI
import UIKit

/// Tarjeta donde aparece el saludo: hueco vacío, spinner, texto en streaming o error.
struct ResponseCard: View {
    let state: GenerationState

    @State private var didCopy = false

    var body: some View {
        VStack(spacing: 20) {
            content
                .frame(maxWidth: .infinity, minHeight: 190)
                .multilineTextAlignment(.center)
            if case .finished(let text) = state, !text.isEmpty {
                actions(for: text)
            }
        }
        .padding(24)
        // Sin esto la tarjeta sería flexible en vertical y el ScrollView le
        // daría todo el espacio libre de la pantalla.
        .fixedSize(horizontal: false, vertical: true)
        .glassEffect(.regular, in: .rect(cornerRadius: 32))
        .animation(.smooth(duration: 0.35), value: state.phase)
    }

    // MARK: - Contenido

    @ViewBuilder
    private var content: some View {
        switch state {
        case .idle:
            placeholder
        case .loading:
            VStack(spacing: 14) {
                ProgressView()
                    .controlSize(.large)
                Text("Thinking…")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .transition(.opacity)
        case .responding(let text), .finished(let text):
            if text.isEmpty {
                placeholder
            } else {
                // Sin ScrollView interno: la tarjeta crece con el texto y es el
                // ScrollView de la pantalla el que se encarga de desplazar.
                Text(text)
                    .font(.title2.weight(.medium))
                    .foregroundStyle(.primary)
                    .textSelection(.enabled)
            }
        case .failed(let message):
            VStack(spacing: 12) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.orange)
                Text("Something went wrong")
                    .font(.headline)
                Text(message)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var placeholder: some View {
        VStack(spacing: 12) {
            Image(systemName: "hand.wave.fill")
                .font(.system(size: 44))
                .foregroundStyle(.tint.secondary)
            Text("Your greeting will show up here")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Acciones sobre el resultado

    private func actions(for text: String) -> some View {
        HStack(spacing: 12) {
            Button {
                UIPasteboard.general.string = text
                didCopy = true
            } label: {
                Label(didCopy ? "Copied" : "Copy", systemImage: didCopy ? "checkmark" : "doc.on.doc")
            }
            .disabled(didCopy)

            ShareLink(item: text) {
                Label("Share", systemImage: "square.and.arrow.up")
            }
        }
        .buttonStyle(.glass)
        .font(.subheadline)
        .sensoryFeedback(.success, trigger: didCopy) { _, new in new }
        .task(id: didCopy) {
            guard didCopy else { return }
            try? await Task.sleep(for: .seconds(2))
            didCopy = false
        }
        .onChange(of: text) { didCopy = false }
        .transition(.blurReplace)
    }
}

// MARK: - Previews

// Un preview por estado: es la forma más rápida de ver los cinco casos del
// enum sin tener que esperar a que el modelo responda en el simulador.

// El cuerpo de `#Preview` no se compila en Release, pero estas constantes
// están fuera del macro y sí llegarían al binario: de ahí el `#if DEBUG`.
#if DEBUG
private let sampleGreeting = "¡Hola! Que hoy te salgan todos los builds a la primera."
private let longGreeting = """
Arrr, buenos días a bordo, grumete: que el viento sople a tu favor, que el \
café esté caliente y que ningún kraken se cruce entre tú y el primer commit \
limpio de la mañana.
"""
#endif

#Preview("1 · Vacío", traits: .sizeThatFitsLayout) {
    ResponseCard(state: .idle)
        .padding()
        .tint(.purple)
}

#Preview("2 · Cargando", traits: .sizeThatFitsLayout) {
    ResponseCard(state: .loading)
        .padding()
        .tint(.purple)
}

#Preview("3 · Escribiendo", traits: .sizeThatFitsLayout) {
    ResponseCard(state: .responding("¡Hola! Que hoy te salgan todos"))
        .padding()
        .tint(.purple)
}

#Preview("4 · Terminado", traits: .sizeThatFitsLayout) {
    ResponseCard(state: .finished(sampleGreeting))
        .padding()
        .tint(.purple)
}

#Preview("5 · Error", traits: .sizeThatFitsLayout) {
    ResponseCard(state: .failed("The model is not available on this device."))
        .padding()
        .tint(.purple)
}

/// El caso que más rompe layouts: un saludo que no cabe en la altura mínima.
#Preview("Texto largo", traits: .sizeThatFitsLayout) {
    ResponseCard(state: .finished(longGreeting))
        .padding()
        .tint(.purple)
}

/// Con texto de accesibilidad el saludo crece mucho; conviene comprobar que
/// la fila de Copiar/Compartir no se rompe.
#Preview("Texto grande", traits: .sizeThatFitsLayout) {
    ResponseCard(state: .finished(sampleGreeting))
        .padding()
        .tint(.purple)
        .environment(\.dynamicTypeSize, .accessibility2)
}

/// Sobre el fondo real, que es donde de verdad se aprecia el efecto glass.
#Preview("Oscuro") {
    ZStack {
        AuroraBackground()
        ResponseCard(state: .finished(sampleGreeting))
            .padding()
    }
    .tint(.purple)
    .preferredColorScheme(.dark)
}
