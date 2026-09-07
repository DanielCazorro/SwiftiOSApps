//
//  FloatingCharacterView.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import SwiftUI

struct FloatingCharacterView: View {
    let imageName: String
    let accessibilityLabel: LocalizedStringKey
    var amplitude: CGFloat = 35

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var isFloating = false

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .offset(y: isFloating ? amplitude : -amplitude)
            .animation(Motion.float(reduceMotion: reduceMotion), value: isFloating)
            .accessibilityLabel(accessibilityLabel)
            .onAppear { isFloating = !reduceMotion }
            .onChange(of: reduceMotion) { _, isReduced in
                isFloating = !isReduced
            }
    }
}

#Preview {
    FloatingCharacterView(imageName: "character-2", accessibilityLabel: "home.character.image")
        .padding()
}
