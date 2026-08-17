//
//  PetDetailView.swift
//  Paws
//
//  Created by Daniel Cazorro on 17/08/2026.
//

import SwiftData
import SwiftUI

struct PetDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var pet: Pet
    @State private var isPresentingEditor = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                header
                infoCard

                if !pet.notes.isEmpty {
                    notesCard
                }
            }
            .padding()
        }
        .background(Color.appBackground)
        .navigationTitle(pet.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation { pet.isFavorite.toggle() }
                } label: {
                    Image(systemName: pet.isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(pet.isFavorite ? .red : .accentColor)
                }
                .accessibilityLabel(pet.isFavorite ? "Remove from favorites" : "Add to favorites")
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") { isPresentingEditor = true }
            }
        }
        .sheet(isPresented: $isPresentingEditor) {
            PetFormView(mode: .edit(pet))
        }
    }

    // MARK: - Sections

    private var header: some View {
        VStack(spacing: 12) {
            PetPhotoView(photo: pet.photo, initials: pet.initials, species: pet.species)
                .frame(height: 260)
                .frame(maxWidth: .infinity)
                .clipShape(.rect(cornerRadius: 28, style: .continuous))
                .shadow(color: .black.opacity(0.15), radius: 14, y: 6)

            Text(pet.name)
                .font(.largeTitle.weight(.semibold))

            HStack(spacing: 8) {
                TagChip(
                    systemImage: pet.species.symbol,
                    title: pet.species.localizedName,
                    tint: pet.species.tint
                )

                if !pet.breed.isEmpty {
                    TagChip(systemImage: "tag.fill", title: pet.breed, tint: .brandSecondary)
                }
            }
        }
    }

    private var infoCard: some View {
        VStack(spacing: 0) {
            if let birthday = pet.birthday {
                infoRow(
                    icon: "calendar",
                    title: "Birthday",
                    value: birthday.formatted(date: .long, time: .omitted)
                )
                Divider()
            }

            if let age = pet.ageDescription {
                infoRow(icon: "clock", title: "Age", value: age)
                Divider()
            }

            if let days = pet.daysUntilBirthday {
                infoRow(
                    icon: "birthday.cake.fill",
                    title: "Next birthday",
                    value: days == 0
                        ? String(localized: "Today!", comment: "Birthday countdown")
                        : String(localized: "In \(days) days", comment: "Birthday countdown")
                )
                Divider()
            }

            infoRow(
                icon: "plus.circle",
                title: "Added",
                value: pet.createdAt.formatted(date: .abbreviated, time: .omitted)
            )
        }
        .cardBackground()
    }

    private var notesCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Notes", systemImage: "note.text")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)

            Text(pet.notes)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .cardBackground()
    }

    private func infoRow(icon: String, title: LocalizedStringKey, value: String) -> some View {
        HStack {
            Label(title, systemImage: icon)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(.subheadline.weight(.medium))
                .multilineTextAlignment(.trailing)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

#Preview {
    NavigationStack {
        PetDetailView(
            pet: Pet(
                name: "Rexy",
                species: .dog,
                breed: "Labrador",
                birthday: .now.addingTimeInterval(-60 * 60 * 24 * 900),
                notes: "Loves the beach and hates the vacuum cleaner.",
                isFavorite: true
            )
        )
    }
    .modelContainer(Pet.preview)
}
