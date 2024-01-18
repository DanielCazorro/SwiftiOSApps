//
//  HeroesRowView.swift
//  kcHerosClase
//
//  Created by Daniel Cazorro Frías on 7/11/23.
//

import SwiftUI

struct HeroesRowView: View {
    var hero: Heros // modelo
    
    var body: some View {
        ZStack {
            // Foto del empleado
            AsyncImage(url: URL(string: hero.photo)) { photo in
                // Foto descargada
                photo
                    .resizable()
                    .cornerRadius(20)
                    .opacity(0.8)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .cornerRadius(20)
                    .opacity(0.8)
            }

            // VStack para nombre y "me gusta"
            VStack(alignment: .leading) {
                // Name
                HStack{
                    Text(hero.name)
                        .font(.title2)
                        .foregroundStyle(.black)
                        .bold()
                        .padding([.top, .leading], 20)
                    Spacer()
                }
                Spacer()
                
                // Like
                if (hero.favorite!){
                    Image(systemName: "heart.circle")
                        .resizable()
                        .foregroundStyle(.red)
                        .frame(width: 40, height: 40)
                        .padding([.leading], 10)
                }else {
                    Image(systemName: "heart.circle")
                        .resizable()
                        .foregroundStyle(.black)
                        .frame(width: 40, height: 40)
                        .padding([.leading], 10)
                }
            }
        }
    }
}

#Preview {
    HeroesRowView(hero: Heros(id: UUID(), name: "Goku", description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.", photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300", favorite: false))
}
