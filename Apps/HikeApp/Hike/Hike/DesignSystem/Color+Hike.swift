//
//  Color+Hike.swift
//  Hike
//
//  Created by Daniel Cazorro on 20/08/2026.
//

import SwiftUI

extension Color {
    static let customGreenLight = Color("ColorGreenLight")
    static let customGreenMedium = Color("ColorGreenMedium")
    static let customGreenDark = Color("ColorGreenDark")
    static let customGrayLight = Color("ColorGrayLight")
    static let customGrayMedium = Color("ColorGrayMedium")
    static let customIndigoMedium = Color("ColorIndigoMedium")
    static let customSalmonLight = Color("ColorSalmonLight")
}

extension ShapeStyle where Self == LinearGradient {
    static func hikeVertical(_ colors: [Color]) -> LinearGradient {
        LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom)
    }

    static var hikeTitle: LinearGradient {
        .hikeVertical([.customGrayLight, .customGrayMedium])
    }

    static var hikeAccent: LinearGradient {
        .hikeVertical([.customGreenLight, .customGreenMedium])
    }
}

#Preview("Palette") {
    let palette: [(String, Color)] = [
        ("GreenLight", .customGreenLight),
        ("GreenMedium", .customGreenMedium),
        ("GreenDark", .customGreenDark),
        ("GrayLight", .customGrayLight),
        ("GrayMedium", .customGrayMedium),
        ("IndigoMedium", .customIndigoMedium),
        ("SalmonLight", .customSalmonLight)
    ]

    return List(palette, id: \.0) { name, color in
        HStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(color)
                .frame(width: 44, height: 28)
            Text(verbatim: name)
        }
    }
}
