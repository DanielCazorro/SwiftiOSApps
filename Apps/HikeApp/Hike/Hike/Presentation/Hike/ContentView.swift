//
//  ContentView.swift
//  Hike
//
//  Created by Daniel Cazorro on 20/08/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = HikeCardViewModel()

    var body: some View {
        ScrollView {
            HikeCardView(viewModel: viewModel)
                .frame(maxWidth: 340)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.vertical, 24)
        }
        .scrollBounceBehavior(.basedOnSize)
        .background(Color(.systemBackground))
    }
}

#Preview {
    ContentView()
}

#Preview("Accessibility XXXL") {
    ContentView()
        .environment(\.dynamicTypeSize, .accessibility3)
}
