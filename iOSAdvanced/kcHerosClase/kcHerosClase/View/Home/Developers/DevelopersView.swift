//
//  DevelopersView.swift
//  kcHerosClase
//
//  Created by Daniel Cazorro Frías on 7/11/23.
//

import SwiftUI

struct DevelopersView: View {
    @StateObject var viewModel: ViewModelDevelopers
    @EnvironmentObject var viewModelRoot: RootViewModel
    
    var body: some View {
        ScrollView {
            if let boots = viewModelRoot.bootcamps,
               let devs = viewModel.developers{
                
                ForEach(boots){ boot in
                    Text(boot.name)
                    
                    // filtrar por developers
                    let devsBoot =
                    devs.filter({$0.bootcamp.id == boot.id})
                    
                    
                    // Si hay developers en el bootcamp
                    if devsBoot.count > 0 {
                        VStack(alignment: .leading) {
                            Text(boot.name)
                                .font(.title)
                                .foregroundStyle(.orange)
                                .bold()
                            
                            // Lista tipo netflix
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack{
                                    ForEach(devsBoot) { dataRow in
                                        VStack {
                                            // Foto
                                            AsyncImage(url: URL(string: dataRow.photo)) { photo in
                                                photo
                                            } placeholder: {
                                                // Place Holder
                                                Image(systemName: "person")
                                                    .resizable()
                                                    .frame(width: 100, height: 100)
                                                    .padding()
                                            }

                                            // Nombre
                                        }
                                    }
                                }
                            }
                            
                        }
                    } else {
                        Text("No")
                    }
                }

                
                
            } else {
                Text("No hay datos")
            }
        }
    }
}

#Preview {
    DevelopersView(viewModel: ViewModelDevelopers(testing: true, boots: RootViewModel(testing: true).bootcamps!))
        .environmentObject(RootViewModel(testing: true))
}
