//
//  HomeView.swift
//  HiSwift
//
//  Created by Daniel Cazorro Frías on 2/3/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.orange.edgesIgnoringSafeArea(.all)
            HStack {
                Image(systemName: "arrow.up.circle")
                    .resizable()
                    .frame(width: 130, height: 130, alignment: .center)
                    .padding()
                VStack(alignment: .leading, spacing: 10) {
                    Text("María Rodriguez")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .bold()
                    Text("Street Nutrition")
                        .foregroundStyle(.green)
                        .font(.title).italic()
                }
            }
        }
        .navigationTitle("HomeView")
        .navigationBarTitleDisplayMode(.automatic)
        .navigationTransition(.automatic)
    }
}

#Preview {
    HomeView()
}
