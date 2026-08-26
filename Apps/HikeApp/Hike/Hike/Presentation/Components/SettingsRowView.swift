//
//  SettingsRowView.swift
//  Hike
//
//  Created by Daniel Cazorro on 24/08/2026.
//

import SwiftUI

struct SettingsRowView<Content: View>: View {
    let titleKey: LocalizedStringKey
    let systemImage: String
    let tint: Color
    @ViewBuilder let content: Content

    var body: some View {
        LabeledContent {
            content
        } label: {
            Label {
                Text(titleKey)
            } icon: {
                Image(systemName: systemImage)
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                    .frame(width: 30, height: 30)
                    .background(tint, in: .rect(cornerRadius: 8, style: .continuous))
            }
        }
    }
}

extension SettingsRowView where Content == Text {
    init(titleKey: LocalizedStringKey, systemImage: String, tint: Color, value: String) {
        self.init(titleKey: titleKey, systemImage: systemImage, tint: tint) {
            Text(value)
                .foregroundStyle(.primary)
                .fontWeight(.heavy)
        }
    }
}

struct SettingsRowLink: View {
    let title: String
    let destination: URL

    var body: some View {
        Link(title, destination: destination)
            .foregroundStyle(.pink)
            .fontWeight(.heavy)
    }
}

extension SettingsRowView where Content == SettingsRowLink {
    init(
        titleKey: LocalizedStringKey,
        systemImage: String,
        tint: Color,
        linkTitle: String,
        destination: URL
    ) {
        self.init(titleKey: titleKey, systemImage: systemImage, tint: tint) {
            SettingsRowLink(title: linkTitle, destination: destination)
        }
    }
}

#Preview {
    List {
        SettingsRowView(
            titleKey: "settings.about.version",
            systemImage: "gear",
            tint: .purple,
            value: "1.0 (1)"
        )

        SettingsRowView(
            titleKey: "settings.about.contact",
            systemImage: "envelope",
            tint: .indigo,
            linkTitle: AppInfo.contactEmail,
            destination: AppLinks.contact
        )
    }
}
