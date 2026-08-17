//
//  PetListView.swift
//  Paws
//
//  Created by Daniel Cazorro on 17/08/2026.
//

import SwiftData
import SwiftUI

/// Root screen: a grid of pet cards with search, filtering and sorting.
struct PetListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var pets: [Pet]
    @State private var viewModel = PetListViewModel()

    private let columns = [
        GridItem(.adaptive(minimum: Metrics.cardMinWidth), spacing: Metrics.cardSpacing)
    ]

    private var visiblePets: [Pet] { viewModel.visiblePets(from: pets) }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()

                ScrollView {
                    if viewModel.hasActiveFilters && !pets.isEmpty {
                        activeFiltersBar
                    }

                    LazyVGrid(columns: columns, spacing: Metrics.cardSpacing) {
                        ForEach(visiblePets) { pet in
                            NavigationLink(value: pet) {
                                PetCardView(pet: pet) {
                                    withAnimation(.snappy) {
                                        viewModel.toggleFavorite(pet, in: modelContext)
                                    }
                                }
                            }
                            .buttonStyle(.plain)
                            .contextMenu { contextMenu(for: pet) }
                            .transition(.scale.combined(with: .opacity))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                    .animation(.snappy, value: visiblePets.map(\.persistentModelID))
                }
                .scrollDismissesKeyboard(.immediately)

                emptyState
            }
            .navigationTitle("Paws")
            .navigationDestination(for: Pet.self) { PetDetailView(pet: $0) }
            .searchable(text: $viewModel.searchText, prompt: Text("Search pets"))
            .toolbar { toolbarContent }
            .sheet(isPresented: $viewModel.isPresentingNewPet) {
                PetFormView(mode: .create)
            }
            .confirmationDialog(
                Text("Delete this pet?"),
                isPresented: Binding(
                    get: { viewModel.petPendingDeletion != nil },
                    set: { if !$0 { viewModel.petPendingDeletion = nil } }
                ),
                titleVisibility: .visible
            ) {
                Button("Delete", role: .destructive) {
                    withAnimation { viewModel.deletePendingPet(in: modelContext) }
                }
                Button("Cancel", role: .cancel) { viewModel.petPendingDeletion = nil }
            } message: {
                Text("This action cannot be undone.")
            }
        }
    }

    // MARK: - Toolbar

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Menu {
                Picker("Sort by", selection: $viewModel.sortOption) {
                    ForEach(PetListViewModel.SortOption.allCases) { option in
                        Label(option.localizedName, systemImage: option.symbol).tag(option)
                    }
                }

                Divider()

                Toggle(isOn: $viewModel.showsFavoritesOnly) {
                    Label("Favorites only", systemImage: "heart.fill")
                }

                Picker("Species", selection: $viewModel.speciesFilter) {
                    Label("All species", systemImage: "pawprint.fill")
                        .tag(PetSpecies?.none)
                    ForEach(viewModel.availableSpecies(in: pets)) { species in
                        Label(species.localizedName, systemImage: species.symbol)
                            .tag(PetSpecies?.some(species))
                    }
                }
            } label: {
                Label("Filters", systemImage: viewModel.hasActiveFilters
                      ? "line.3.horizontal.decrease.circle.fill"
                      : "line.3.horizontal.decrease.circle")
            }
            .disabled(pets.isEmpty)
        }

        ToolbarItem(placement: .topBarTrailing) {
            Button("Add a new pet", systemImage: "plus.circle.fill") {
                viewModel.isPresentingNewPet = true
            }
        }
    }

    @ViewBuilder
    private func contextMenu(for pet: Pet) -> some View {
        Button {
            withAnimation(.snappy) { viewModel.toggleFavorite(pet, in: modelContext) }
        } label: {
            Label(pet.isFavorite ? "Remove from favorites" : "Add to favorites",
                  systemImage: pet.isFavorite ? "heart.slash" : "heart")
        }

        Button(role: .destructive) {
            viewModel.confirmDeletion(of: pet)
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }

    // MARK: - Supporting views

    private var activeFiltersBar: some View {
        HStack {
            Text("Showing \(visiblePets.count) of \(pets.count)")
                .font(.footnote)
                .foregroundStyle(.secondary)

            Spacer()

            Button("Clear filters", systemImage: "xmark.circle.fill") {
                withAnimation { viewModel.clearFilters() }
            }
            .font(.footnote.weight(.medium))
            .labelStyle(.titleAndIcon)
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
    }

    @ViewBuilder
    private var emptyState: some View {
        if pets.isEmpty {
            CustomContentUnavailableView(
                icon: "dog.circle",
                title: "No pets yet",
                description: "Add your first furry friend to get started.",
                actionTitle: "Add a pet",
                action: { viewModel.isPresentingNewPet = true }
            )
        } else if visiblePets.isEmpty {
            CustomContentUnavailableView(
                icon: "magnifyingglass.circle",
                title: "No matches",
                description: "Try a different search or clear the filters.",
                actionTitle: "Clear filters",
                action: { withAnimation { viewModel.clearFilters() } }
            )
        }
    }
}

#Preview("Sample data") {
    PetListView()
        .modelContainer(Pet.preview)
}

#Preview("Empty") {
    PetListView()
        .modelContainer(for: Pet.self, inMemory: true)
}

#Preview("Español") {
    PetListView()
        .modelContainer(Pet.preview)
        .environment(\.locale, .init(identifier: "es"))
}
