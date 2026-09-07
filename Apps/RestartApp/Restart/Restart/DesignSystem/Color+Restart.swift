//
//  Color+Restart.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import SwiftUI

extension Color {
    static let brandBlue = Color("ColorBlue")
    static let brandRed = Color("ColorRed")
}

extension ShapeStyle where Self == LinearGradient {
    static var brandBackground: LinearGradient {
        LinearGradient(
            colors: [.brandBlue, .brandBlue.mix(with: .black, by: 0.25)],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

#Preview("Palette") {
    let palette: [(String, Color)] = [("Blue", .brandBlue), ("Red", .brandRed)]

    return List(palette, id: \.0) { name, color in
        HStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(color)
                .frame(width: 44, height: 28)
            Text(verbatim: name)
        }
    }
}
