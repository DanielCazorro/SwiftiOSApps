//
//  SettingsLabelView.swift
//  Fruits
//
//  Created by Daniel Cazorro on 30/09/2026.
//

import SwiftUI

struct SettingsLabelView: View {
    var labelText: String
    var labelImage: String

    var body: some View {
        HStack {
            Text(labelText.uppercased()).fontWeight(.bold)
            Spacer()
            Image(systemName: labelImage)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SettingsLabelView(labelText: "Frctus", labelImage: "info.circle")
        .padding()
}
