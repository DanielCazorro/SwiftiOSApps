//
//  SourceLinkView.swift
//  Fruits
//
//  Created by Daniel Cazorro on 28/09/2026.
//

import SwiftUI

struct SourceLinkView: View {
    var body: some View {
        GroupBox() {
            HStack {
                Text("Content source")
                Spacer()
                if let url = URL(string: "https://wikipedia.com") {
                    Link("Wikipedia", destination: url)
                }
                Image(systemName: "arrow.up.right.square")
            }
            .font(.footnote)
        }
    }
}

#Preview {
    SourceLinkView()
}
