//
//  Layout.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import SwiftUI

enum Layout {
    static let maxContentWidth: CGFloat = 480
    static let circleDiameter: CGFloat = 260
    static let knobSize: CGFloat = 80
    static let controlHeight: CGFloat = 80
    static let horizontalPadding: CGFloat = 40
}

extension View {
    func readableContentWidth() -> some View {
        frame(maxWidth: Layout.maxContentWidth)
            .frame(maxWidth: .infinity)
    }
}
