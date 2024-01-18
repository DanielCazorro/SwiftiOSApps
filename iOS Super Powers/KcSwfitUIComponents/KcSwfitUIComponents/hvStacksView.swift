//
//  hvStacks.swift
//  KcSwfitUIComponents
//
//  Created by Daniel Cazorro Frías on 31/10/23.
//

import SwiftUI

struct hvStacks: View {
    var body: some View {
        VStack{
            HStack{
                Text("Mi nombre es:")
                Text("Daniel")
            }
            HStack {
                Text("Mi nombre es:")
                Text("Carlos")
            }
        }
    }
}

#Preview {
    hvStacks()
}
