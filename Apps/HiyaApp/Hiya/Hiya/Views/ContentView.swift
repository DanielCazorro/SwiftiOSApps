//
//  ContentView.swift
//  Hiya
//
//  Created by Daniel Cazorro on 04/08/2026.
//

import FoundationModels
import SwiftUI

struct ContentView: View {
    @State private var viewModel = HiyaViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                AuroraBackground(isActive: viewModel.state.isWorking)

                switch viewModel.availability {
                case .available:
                    generator
                case .unavailable(let reason):
                    ModelUnavailableView(reason: reason)
                }
            }
            .navigationTitle("Hiya")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if viewModel.state != .idle {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Clear", systemImage: "eraser") {
                            withAnimation(.smooth) { viewModel.clear() }
                        }
                    }
                }
            }
        }
        .tint(.purple)
        .task { viewModel.prepare() }
    }

    // MARK: - Pantalla principal

    private var generator: some View {
        ScrollView {
            VStack(spacing: 20) {
                ResponseCard(state: viewModel.state)

                OptionsCard(
                    style: $viewModel.style,
                    language: $viewModel.language,
                    topic: $viewModel.topic,
                    creativity: $viewModel.creativity,
                    isEnabled: !viewModel.state.isWorking,
                    onSubmit: viewModel.generate
                )
            }
            .padding(.horizontal, 20)
            .padding(.top, 8)
        }
        .scrollDismissesKeyboard(.interactively)
        .safeAreaInset(edge: .bottom) {
            actionBar
        }
    }

    // MARK: - Botón principal

    private var actionBar: some View {
        HStack(spacing: 12) {
            Button(action: viewModel.generate) {
                Label(buttonTitle, systemImage: "hand.wave.fill")
                    .font(.title3.weight(.semibold))
                    .padding(.vertical, 10)
            }
            .buttonStyle(.glassProminent)
            .buttonSizing(.flexible)
            .disabled(!viewModel.canGenerate)

            if viewModel.state.isWorking {
                Button("Stop", systemImage: "stop.fill") {
                    withAnimation(.smooth) { viewModel.cancel() }
                }
                .labelStyle(.iconOnly)
                .font(.title3)
                .padding(.vertical, 14)
                .padding(.horizontal, 4)
                .buttonStyle(.glass)
                .transition(.blurReplace)
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
        .animation(.smooth(duration: 0.3), value: viewModel.state.isWorking)
        .sensoryFeedback(.impact, trigger: viewModel.state.isWaitingFirstToken) { _, new in new }
    }

    private var buttonTitle: LocalizedStringKey {
        switch viewModel.state {
        case .idle, .loading: "Say hi"
        case .responding: "Writing…"
        case .finished, .failed: "Say hi again"
        }
    }
}

// MARK: - Previews

// Estos previews montan la pantalla completa, así que dependen del modelo real:
// saldrán en estado vacío o en la pantalla de "no disponible" según el Mac.
// Para revisar los estados de la respuesta, usa los previews de `ResponseCard`.

#Preview("Pantalla completa") {
    ContentView()
}

#Preview("Oscuro") {
    ContentView()
        .preferredColorScheme(.dark)
}

#Preview("Inglés") {
    ContentView()
        .environment(\.locale, Locale(identifier: "en"))
}

#Preview("Texto grande") {
    ContentView()
        .environment(\.dynamicTypeSize, .accessibility1)
}
