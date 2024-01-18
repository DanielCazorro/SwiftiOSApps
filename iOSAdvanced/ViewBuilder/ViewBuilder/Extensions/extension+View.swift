//
//  extension+View.swift
//  ViewBuilder
//
//  Created by Daniel Cazorro Frías on 7/11/23.
//

import SwiftUI

/*
Text("Hello)  (view)
 .bold(){
 >>> Text
 >>> Text aplicado el bold
 .foregroundColor(.white) {
 >>> Text.Bold
 <<< Text.Bold.white
 }
 */

extension View {
    
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if (condition) {
            transform(self)
        } else {
            self
        }
    }
    
}


struct KcButton <Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    var content: Content
    
    init(@ViewBuilder content: ()->Content){
        self.content = content()
    }
    
    var body: some View {
        // Aquí maquetamos...
        content
            .padding()
            .if(colorScheme == .light) { View in
                View.background(.blue)
            }
            .if(colorScheme == .dark) { View in
                View.background(.gray)
            }
            .foregroundStyle(.white)
            .cornerRadius(20)
    }
    
    
}
