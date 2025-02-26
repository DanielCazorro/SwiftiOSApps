//
//  ContentView.swift
//  HiSwift
//
//  Created by Daniel Cazorro Frías on 24/2/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingAlert = false

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.orange)
                .imageScale(.large)
                .foregroundStyle(.thickMaterial)
            Text("Hi, world!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.pink)
                .multilineTextAlignment(.center)
            Spacer()
            Button("Tap me") {
                isShowingAlert.toggle()
                print(isShowingAlert)
            }.alert(isPresented: $isShowingAlert) {
                Alert(title: Text("Title"), message: Text("Message"), dismissButton: .default(Text("Dismiss")))
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
