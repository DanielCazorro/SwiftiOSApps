//
//  CustomButtonView.swift
//  Hike
//
//  Created by Daniel Cazorro on 22/08/2026.
//

import SwiftUI

struct CustomButtonView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [.white, .customGreenLight, .customGreenMedium],
                        startPoint: .top,
                        endPoint: .bottom)
                )

            Circle()
                .stroke(
                    LinearGradient(
                        colors: [.customGrayLight, .customGrayMedium],
                        startPoint: .top,
                        endPoint: .bottom),
                    lineWidth: 4)

                    Image(systemName: "figure.hiking")
                .fontWeight(.black)
                .font(.system(size: 30))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.customGreenLight, .customGrayMedium],
                        startPoint: .top,
                        endPoint: .bottom))
        }// Zstack
        .frame(width: 58, height: 58)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CustomButtonView()
        .padding()
}
