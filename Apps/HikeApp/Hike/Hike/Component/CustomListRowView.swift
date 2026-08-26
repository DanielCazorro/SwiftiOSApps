//
//  CustomListRowView.swift
//  Hike
//
//  Created by Daniel Cazorro on 24/08/2026.
//

import SwiftUI

struct CustomListRowView: View {
    // MARK: - Properties
    let rowLabel: String
    let rowIcon: String
    var rowContent: String? = nil
    let rowTintColor: Color
    var rowLinkLabel: String? = nil
    var rowLinkDestination: String? = nil

    var body: some View {
        LabeledContent {
                // Content
            if let rowContent {
                Text(rowContent)
                    .foregroundStyle(.primary)
                    .fontWeight(.heavy)
            } else if let rowLinkLabel, let rowLinkDestination, let url = URL(string: rowLinkDestination) {
                Link(rowLinkLabel, destination: url)
                    .foregroundStyle(.pink)
                    .fontWeight(.heavy)
            } else {
                EmptyView()
            }
        } label: {
                // Label
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 30, height: 30)
                        .foregroundStyle(rowTintColor)
                    Image(systemName: rowIcon)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                }
                Text(rowLabel)
            }
        }
    }
}

#Preview {
    List {
        CustomListRowView(
            rowLabel: "Website",
            rowIcon: "globe",
            rowContent: nil,
            rowTintColor: .pink,
            rowLinkLabel: "Credo Academy",
            rowLinkDestination: "https://credo.academy")
    }
}
