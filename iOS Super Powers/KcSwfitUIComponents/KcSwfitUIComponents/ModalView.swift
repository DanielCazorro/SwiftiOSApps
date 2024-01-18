//
//  ModalView.swift
//  KcSwfitUIComponents
//
//  Created by Daniel Cazorro Frías on 31/10/23.
//

import SwiftUI

struct ModalView: View {
    @State var showDetail = false
    
    var body: some View {
        Button(action: {
            // Action Here
            showDetail.toggle()
        }, label: {
            Text("Show Modal")
        })
        .sheet(isPresented: $showDetail, content: {
            
            DetailModalView(showDetail: $showDetail)
        })
    }
}

#Preview {
    ModalView()
}
