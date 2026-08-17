//
//  CustomContentUnavailableView.swift
//  Paws
//
//  Created by Daniel Cazorro on 17/08/2026.
//

import SwiftUI

struct CustomContentUnavailableView: View {
    var icon: String
    var title: LocalizedStringKey
    var description: LocalizedStringKey
    var actionTitle: LocalizedStringKey?
    var action: (() -> Void)?

    var body: some View {
        ContentUnavailableView {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 88)
                .foregroundStyle(.brandGradient)
                .padding(.bottom, 8)

            Text(title)
                .font(.title2.weight(.semibold))
                .foregroundStyle(.primary)
        } description: {
            Text(description)
                .foregroundStyle(.secondary)
        } actions: {
            if let actionTitle, let action {
                Button(actionTitle, action: action)
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .controlSize(.large)
            }
        }
    }
}

#Preview {
    CustomContentUnavailableView(
        icon: "dog.circle",
        title: "No pets yet",
        description: "Add your first furry friend to get started.",
        actionTitle: "Add a pet",
        action: {}
    )
}
