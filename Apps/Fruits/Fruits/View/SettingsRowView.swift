//
//  SettingsRowView.swift
//  Fruits
//
//  Created by Daniel Cazorro on 01/10/2026.
//

import SwiftUI

struct SettingsRowView: View {
    var name: String
    var content: String? = nil
    var linkLabel: String? = nil
    var linkDestination: String? = nil

    var body: some View {
        VStack {
            Divider().padding(.vertical, 4)

            HStack {
                Text(name).foregroundStyle(.gray)
                Spacer()
                if (content != nil) {
                    Text(content ?? "Default")
                } else if (linkLabel != nil && linkDestination != nil) {
                    Link(
                        linkLabel ?? "Default",
                        destination: URL(
                            string: "https://\(linkDestination ?? "default")") ?? .applicationDirectory)
                    Image(systemName: "arrow.up.right.square")
                        .foregroundStyle(.pink)
                }
                else {
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    SettingsRowView(name: "Developer", content: "Daniel")
}

#Preview("Dark") {
    SettingsRowView(
        name: "Developer",
        content: "Daniel",
        linkLabel: "SwiftUI Masterclass",
        linkDestination: "swiftuimasterclass.com"
    )
        .preferredColorScheme(.dark)
}
