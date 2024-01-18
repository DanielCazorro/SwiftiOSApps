//
//  HomeView.swift
//  kcHerosClase
//
//  Created by Daniel Cazorro Frías on 6/11/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var rootviewModel: RootViewModel
    
    var body: some View {
        TabView {
            
            VStack{
                HerosView(viewModel: viewModelHeros())
                Button(action: {
                    rootviewModel.CloseSession()
                }, label: {
                    Text("Close Session")
                })
            }
            .tabItem {
                Image(systemName: "house")
                Text("Heros")
            }
            
            DevelopersView(viewModel: ViewModelDevelopers())
            
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(RootViewModel())
}
