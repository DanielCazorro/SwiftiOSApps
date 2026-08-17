//
//  PetCardView.swift
//  Paws
//
//  Created by Daniel Cazorro on 17/08/2026.
//

import SwiftUI

struct PetCardView: View {
    let pet: Pet
    let onToggleFavorite: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            PetPhotoView(photo: pet.photo, initials: pet.initials, species: pet.species)
                .frame(height: 140)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .topTrailing) { favoriteButton }
                .overlay(alignment: .bottomLeading) { birthdayBadge }

            VStack(alignment: .leading, spacing: 8) {
                Text(pet.name)
                    .font(.headline)
                    .lineLimit(1)
                    .foregroundStyle(.primary)

                TagChip(
                    systemImage: pet.species.symbol,
                    title: pet.breed.isEmpty ? pet.species.localizedName : pet.breed,
                    tint: pet.species.tint
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
        }
        .cardBackground()
        .contentShape(.rect(cornerRadius: Metrics.cardCornerRadius))
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel)
    }

    private var favoriteButton: some View {
        Button(action: onToggleFavorite) {
            Image(systemName: pet.isFavorite ? "heart.fill" : "heart")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(pet.isFavorite ? .red : .white)
                .padding(8)
                .background(.ultraThinMaterial, in: .circle)
        }
        .buttonStyle(.plain)
        .padding(8)
        .accessibilityLabel(pet.isFavorite
                            ? Text("Remove \(pet.name) from favorites")
                            : Text("Add \(pet.name) to favorites"))
    }

    @ViewBuilder
    private var birthdayBadge: some View {
        if pet.isBirthdayToday {
            TagChip(
                systemImage: "birthday.cake.fill",
                title: String(localized: "Happy birthday!", comment: "Badge on the pet card"),
                tint: .brandSecondary
            )
            .background(.ultraThinMaterial, in: .capsule)
            .padding(8)
        }
    }

    private var accessibilityLabel: Text {
        let breed = pet.breed.isEmpty ? pet.species.localizedName : pet.breed
        return Text(verbatim: "\(pet.name), \(breed)")
    }
}

#Preview {
    let pet = Pet(name: "Rexy", species: .dog, breed: "Labrador", isFavorite: true)
    return PetCardView(pet: pet, onToggleFavorite: {})
        .frame(width: 180)
        .padding()
        .background(Color.appBackground)
}
