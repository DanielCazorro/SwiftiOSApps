//
//  AnotherView.swift
//  HiSwift
//
//  Created by Daniel Cazorro Frías on 12/3/25.
//

import SwiftUI

struct AnotherView: View {
    @State private var show = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ModalView()) {
                    Text("Second View")
                        .navigationTitle("Second View")
                        .toolbar {
                            HStack {
                                NavigationLink(destination: ContentView()) {
                                    Image(systemName: "house")
                                }
                                NavigationLink(destination: ModalView()) {
                                    Image(systemName: "plus")
                                }
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    AnotherView()
}
