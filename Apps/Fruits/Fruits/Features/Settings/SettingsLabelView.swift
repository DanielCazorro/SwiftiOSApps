//
//  SettingsLabelView.swift
//  Fruits
//
//  Created by Daniel Cazorro on 30/09/2026.
//

import SwiftUI

struct SettingsLabelView: View {
    let title: LocalizedStringKey
    let systemImage: String

    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
                .textCase(.uppercase)
            Spacer()
            Image(systemName: systemImage)
                .accessibilityHidden(true)
        }
        .accessibilityAddTraits(.isHeader)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SettingsLabelView(title: "Fruits", systemImage: "info.circle")
        .padding()
}
