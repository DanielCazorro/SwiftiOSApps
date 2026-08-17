//
//  PetFormView.swift
//  Paws
//
//  Created by Daniel Cazorro on 17/08/2026.
//

import PhotosUI
import SwiftData
import SwiftUI

/// Single form used both to create and to edit a pet, driven by `PetFormViewModel`.
struct PetFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: PetFormViewModel
    @FocusState private var isNameFocused: Bool

    init(mode: PetFormViewModel.Mode) {
        _viewModel = State(initialValue: PetFormViewModel(mode: mode))
    }

    var body: some View {
        NavigationStack {
            Form {
                photoSection
                detailsSection
                birthdaySection
                notesSection
            }
            .scrollDismissesKeyboard(.interactively)
            .scrollContentBackground(.hidden)
            .background(Color.appBackground)
            .navigationTitle(viewModel.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.save(in: modelContext)
                        dismiss()
                    }
                    .disabled(!viewModel.canSave)
                    .fontWeight(.semibold)
                }
            }
            .onChange(of: viewModel.photoPickerItem) { _, newItem in
                Task { await viewModel.loadPhoto(from: newItem) }
            }
            .alert(
                "Something went wrong",
                isPresented: Binding(
                    get: { viewModel.errorMessage != nil },
                    set: { if !$0 { viewModel.errorMessage = nil } }
                )
            ) {
                Button("OK", role: .cancel) { viewModel.errorMessage = nil }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .task {
                guard !viewModel.isEditing else { return }
                isNameFocused = true
            }
        }
    }

    // MARK: - Sections

    private var photoSection: some View {
        Section {
            VStack(spacing: 12) {
                PetPhotoView(
                    photo: viewModel.photo,
                    initials: viewModel.name.isEmpty ? "" : String(viewModel.name.prefix(2)).uppercased(),
                    species: viewModel.species,
                    showsInitials: !viewModel.name.isEmpty
                )
                .frame(width: 160, height: 160)
                .clipShape(.circle)
                .overlay { Circle().strokeBorder(.white.opacity(0.6), lineWidth: 4) }
                .shadow(color: .black.opacity(0.15), radius: 8, y: 4)
                .overlay {
                    if viewModel.isLoadingPhoto {
                        ProgressView()
                            .controlSize(.large)
                            .padding(20)
                            .background(.ultraThinMaterial, in: .circle)
                    }
                }

                HStack(spacing: 12) {
                    PhotosPicker(selection: $viewModel.photoPickerItem, matching: .images) {
                        Label("Choose photo", systemImage: "photo.badge.plus")
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)

                    if viewModel.photo != nil {
                        Button(role: .destructive) {
                            viewModel.removePhoto()
                        } label: {
                            Label("Remove", systemImage: "trash")
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                    }
                }
                .font(.subheadline)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .listRowBackground(Color.clear)
        }
    }

    private var detailsSection: some View {
        Section("Details") {
            LabeledContent("Name") {
                TextField("Name", text: $viewModel.name)
                    .focused($isNameFocused)
                    .textInputAutocapitalization(.words)
                    .multilineTextAlignment(.trailing)
            }

            Picker("Species", selection: $viewModel.species) {
                ForEach(PetSpecies.allCases) { species in
                    Label(species.localizedName, systemImage: species.symbol)
                        .tag(species)
                }
            }

            LabeledContent("Breed") {
                TextField("Breed", text: $viewModel.breed)
                    .textInputAutocapitalization(.words)
                    .multilineTextAlignment(.trailing)
            }

            Toggle(isOn: $viewModel.isFavorite) {
                Label("Favorite", systemImage: "heart.fill")
            }
            .tint(.red)
        }
    }

    private var birthdaySection: some View {
        Section("Birthday") {
            Toggle("Has a known birthday", isOn: $viewModel.hasBirthday.animation())

            if viewModel.hasBirthday {
                DatePicker(
                    "Birthday",
                    selection: $viewModel.birthday,
                    in: ...Date.now,
                    displayedComponents: .date
                )
            }
        }
    }

    private var notesSection: some View {
        Section("Notes") {
            TextField("Anything worth remembering", text: $viewModel.notes, axis: .vertical)
                .lineLimit(3...8)
        }
    }
}

#Preview("Create") {
    PetFormView(mode: .create)
        .modelContainer(Pet.preview)
}

#Preview("Edit") {
    PetFormView(mode: .edit(Pet(name: "Rexy", species: .dog, breed: "Labrador")))
        .modelContainer(Pet.preview)
}
