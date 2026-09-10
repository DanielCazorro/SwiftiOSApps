//
//  ControlIconLabel.swift
//  Pinch
//
//  Created by Daniel Cazorro on 09/09/2026.
//

import SwiftUI

struct ControlIconLabel: View {
    let icon: String

    var body: some View {
        Image(systemName: icon)
            .font(.system(size: Layout.controlIconSize))
            .symbolRenderingMode(.hierarchical)
            .frame(minWidth: 44, minHeight: 44)
            .contentShape(.rect)
    }
}

#Preview {
    HStack {
        ControlIconLabel(icon: "minus.magnifyingglass")
        ControlIconLabel(icon: "arrow.up.left.and.down.right.magnifyingglass")
        ControlIconLabel(icon: "plus.magnifyingglass")
    }
    .padding()
    .preferredColorScheme(.dark)
}
