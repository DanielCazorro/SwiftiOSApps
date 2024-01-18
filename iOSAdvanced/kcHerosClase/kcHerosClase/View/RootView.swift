//
//  RootView.swift
//  kcHerosClase
//
//  Created by Daniel Cazorro Frías on 6/11/23.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        // Status Box or ViewRouter
        
        switch rootViewModel.status {
        case Status.none:
            withAnimation {
                LoginView() // Login
            }
          
        case .register:
            Text("Registro")
        case .loading:
            withAnimation {
                LoaderView()
            }

        case .error(error: let errorString):
            withAnimation {
                ErrorView(error: errorString)
            }

        case . loaded:
            withAnimation {
                HomeView() // La home de la app
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(RootViewModel())
}
