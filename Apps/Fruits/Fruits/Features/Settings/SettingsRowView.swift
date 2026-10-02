//
//  SettingsRowView.swift
//  Fruits
//
//  Created by Daniel Cazorro on 01/10/2026.
//

import SwiftUI

struct SettingsRowView: View {
    private enum Value {
        case text(String)
        case link(label: String, destination: URL)
    }

    private let name: LocalizedStringKey
    private let value: Value

    init(name: LocalizedStringKey, content: String) {
        self.name = name
        value = .text(content)
    }

    init(name: LocalizedStringKey, linkLabel: String, destination: URL?) {
        self.name = name
        value = destination.map { .link(label: linkLabel, destination: $0) } ?? .text(linkLabel)
    }

    var body: some View {
        VStack {
            Divider()
                .padding(.vertical, 4)

            HStack {
                Text(name)
                    .foregroundStyle(.secondary)
                Spacer()
                switch value {
                case .text(let content):
                    Text(content)
                case .link(let label, let destination):
                    Link(destination: destination) {
                        HStack(spacing: 4) {
                            Text(label)
                            Image(systemName: "arrow.up.right.square")
                                .foregroundStyle(.pink)
                        }
                    }
                }
            }
            .accessibilityElement(children: .combine)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    VStack {
        SettingsRowView(name: "Version", content: "1.0")
        SettingsRowView(name: "Source code", linkLabel: "SwiftiOSApps", destination: ExternalLink.sourceCode)
    }
    .padding()
}
