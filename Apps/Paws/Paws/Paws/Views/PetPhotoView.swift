//
//  PetPhotoView.swift
//  Paws
//
//  Created by Daniel Cazorro on 17/08/2026.
//

import SwiftUI

/// Shows the pet photo, or a branded placeholder with its initials when there
/// is none. Used by the card, the detail header and the form.
struct PetPhotoView: View {
    let photo: Data?
    let initials: String
    let species: PetSpecies
    var showsInitials: Bool = true

    var body: some View {
        ZStack {
            if let photo, let image = UIImage(data: photo) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                species.gradient
                    .overlay {
                        if showsInitials {
                            Text(initials)
                                .font(.system(size: 44, weight: .bold, design: .rounded))
                                .foregroundStyle(.white.opacity(0.9))
                                .minimumScaleFactor(0.5)
                                .padding()
                        } else {
                            Image(systemName: species.symbol)
                                .font(.system(size: 52))
                                .foregroundStyle(.white.opacity(0.9))
                        }
                    }
            }
        }
        .clipped()
        .accessibilityHidden(true)
    }
}

#Preview {
    HStack {
        PetPhotoView(photo: nil, initials: "RX", species: .dog)
            .frame(width: 140, height: 140)
            .clipShape(.rect(cornerRadius: 20))
        PetPhotoView(photo: nil, initials: "", species: .cat, showsInitials: false)
            .frame(width: 140, height: 140)
            .clipShape(.circle)
    }
}
