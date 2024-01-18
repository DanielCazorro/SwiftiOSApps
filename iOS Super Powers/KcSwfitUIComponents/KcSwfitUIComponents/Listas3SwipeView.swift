//
//  Listas3SwipeView.swift
//  KcSwfitUIComponents
//
//  Created by Daniel Cazorro Frías on 31/10/23.
//

import SwiftUI

struct Listas3SwipeView: View {
    
    @State private var bestFriends = ["Juan", "Laura", "Marco"]
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(bestFriends, id:\.self) { friend in
                    Text(friend)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            // Acción 1
                            Button(action: {
                                // Action Here
                            }, label: {
                                Label("Silenciar", systemImage: "bell.fill")
                            })
                            .tint(.red)
                            
                            
                            // Acción 2
                            Button(action: {
                                // Action Here
                            }, label: {
                                Label("Video", systemImage: "video.fill")
                            })
                            .tint(.green)
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            // Acción 1
                            Button(action: {
                                // Action Here
                            }, label: {
                                Label("Llamar", systemImage: "phone")
                            })
                            .tint(.gray)

                        }
                }
            }
            .refreshable {
                // PoolToRefresh
                bestFriends.append("New")

            }
            .navigationTitle("Amigos")
            
        }
    }
}

#Preview {
    Listas3SwipeView()
}
