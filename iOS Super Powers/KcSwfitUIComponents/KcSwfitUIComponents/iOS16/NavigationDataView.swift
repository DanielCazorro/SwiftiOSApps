//
//  NavigationDataView.swift
//  KcSwfitUIComponents
//
//  Created by Daniel Cazorro Frías on 31/10/23.
//

import SwiftUI

struct Scores: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let published: Bool
}




struct NavigationDataView: View {
    
    var scores: [Scores] = [
        Scores(title: "Star Wars", published: true),
        Scores(title: "The Empire Stricks Back", published: true),
        Scores(title: "Return of the Jedi", published: false)
    ]
    
    
    var body: some View {
        NavigationStack{
            
            NavigationLink(value: 1) {
                HStack{
                    Text("Navega por Int")
                    
                }
            }
            
            List{
                ForEach(scores){ score in
                    NavigationLink(value: score) {
                        HStack{
                            Text(score.title)
                            Spacer()
                            Image(systemName: score.published ? "music.mic.circle.fill" : "music.mic.circle")
                        }
                    }
                }
            }
            
            NavigationLink(value: 0) {
                HStack{
                    Text("Navega por int == 0")
                    
                }
            }
            .navigationTitle("Navegar por datos")
            .navigationDestination(for: Scores.self) { value in
                if value.published {
                    // True
                    Text("Ya está publicado")
                } else {
                    // False
                    Text("No está publicado")
                }
            }
            
            
            .navigationDestination(for: Int.self) { value in
                if value == 1 {
                    // True
                    Text("Entero = 1")
                } else {
                    // False
                    Text("Entero != 1")
                }
            }
            
            

            
        }
    }
}

#Preview {
    NavigationDataView()
}
