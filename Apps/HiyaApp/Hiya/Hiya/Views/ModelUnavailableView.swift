//
//  ModelUnavailableView.swift
//  Hiya
//
//  Created by Daniel Cazorro on 04/08/2026.
//

import FoundationModels
import SwiftUI
import UIKit

/// Pantalla que explica por qué no se puede usar Apple Intelligence.
struct ModelUnavailableView: View {
    let reason: SystemLanguageModel.Availability.UnavailableReason

    var body: some View {
        ContentUnavailableView {
            Label("Apple Intelligence unavailable", systemImage: symbol)
        } description: {
            Text(message)
        } actions: {
            if reason == .appleIntelligenceNotEnabled, let url = URL(string: UIApplication.openSettingsURLString) {
                Link("Open Settings", destination: url)
                    .buttonStyle(.glassProminent)
            }
        }
    }

    private var symbol: String {
        switch reason {
        case .deviceNotEligible: "iphone.slash"
        case .appleIntelligenceNotEnabled: "gearshape"
        case .modelNotReady: "clock.arrow.trianglehead.counterclockwise.rotate.90"
        @unknown default: "exclamationmark.triangle"
        }
    }

    private var message: LocalizedStringKey {
        switch reason {
        case .deviceNotEligible:
            "This device isn't eligible for Apple Intelligence."
        case .appleIntelligenceNotEnabled:
            "Turn on Apple Intelligence in Settings to use Hiya."
        case .modelNotReady:
            "The model is still downloading. Try again in a moment."
        @unknown default:
            "Apple Intelligence isn't available right now."
        }
    }
}

// MARK: - Previews

// Estas tres pantallas son casi imposibles de ver en el simulador: haría falta
// desactivar Apple Intelligence o un dispositivo no compatible. Los previews
// son la única forma práctica de revisarlas.

#Preview("Sin activar") {
    ModelUnavailableView(reason: .appleIntelligenceNotEnabled)
        .tint(.purple)
}

#Preview("Dispositivo no compatible") {
    ModelUnavailableView(reason: .deviceNotEligible)
        .tint(.purple)
}

#Preview("Modelo descargando") {
    ModelUnavailableView(reason: .modelNotReady)
        .tint(.purple)
}

#Preview("Inglés") {
    ModelUnavailableView(reason: .appleIntelligenceNotEnabled)
        .tint(.purple)
        .environment(\.locale, Locale(identifier: "en"))
}

#Preview("Oscuro") {
    ZStack {
        AuroraBackground()
        ModelUnavailableView(reason: .appleIntelligenceNotEnabled)
    }
    .tint(.purple)
    .preferredColorScheme(.dark)
}
