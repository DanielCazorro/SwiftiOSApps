//
//  SourceLinkView.swift
//  Fruits
//
//  Created by Daniel Cazorro on 28/09/2026.
//

import SwiftUI

struct SourceLinkView: View {
    var body: some View {
        GroupBox {
            HStack {
                Text("Content source")
                Spacer()
                if let url = ExternalLink.contentSource {
                    Link(destination: url) {
                        HStack(spacing: 4) {
                            Text(verbatim: "Wikipedia")
                            Image(systemName: "arrow.up.right.square")
                        }
                    }
                }
            }
            .font(.footnote)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SourceLinkView()
        .padding()
}
