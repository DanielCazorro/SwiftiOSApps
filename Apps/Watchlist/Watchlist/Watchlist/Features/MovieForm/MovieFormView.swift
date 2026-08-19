//
//  MovieFormView.swift
//  Watchlist
//
//  Created by Daniel Cazorro on 19/08/2026.
//

import SwiftUI
import SwiftData

/// Sheet used both to add a new film and to edit an existing one.
struct MovieFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isTitleFocused: Bool

    @State private var model: MovieFormViewModel

    init(route: MovieFormRoute) {
        _model = State(initialValue: MovieFormViewModel(route: route))
    }

    var body: some View {
        NavigationStack {
            Form {
                titleSection
                detailsSection
                notesSection
            }
            .navigationTitle(Text(model.navigationTitle))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("action.cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(String(localized: model.saveButtonTitle), action: save)
                        .fontWeight(.semibold)
                        .disabled(!model.canSave)
                }
            }
            .scrollDismissesKeyboard(.interactively)
            // Opening straight into the text field saves a tap on the one screen
            // where the user always has something to type.
            .onAppear { isTitleFocused = !model.isEditing }
            .sensoryFeedback(.success, trigger: model.draft.isWatched)
        }
        .presentationDragIndicator(.visible)
    }

    // MARK: - Sections

    private var titleSection: some View {
        Section {
            TextField(text: $model.draft.title) {
                Text("form.field.title")
            }
            .focused($isTitleFocused)
            .font(.title3)
            .textInputAutocapitalization(.words)
            .autocorrectionDisabled()
            .submitLabel(.done)
            .onSubmit { if model.canSave { save() } }
        } header: {
            Text("form.section.title")
        } footer: {
            if let message = model.validationMessage {
                Label(String(localized: message), systemImage: "exclamationmark.triangle.fill")
                    .foregroundStyle(.orange)
            } else if model.showsCharacterCount {
                Text("form.charactersRemaining \(model.remainingTitleCharacters)")
                    .monospacedDigit()
            }
        }
    }

    /// Genre, watched state and rating share one section: the separate headers
    /// the first version had only repeated the row labels underneath them.
    private var detailsSection: some View {
        Section {
            Picker(selection: $model.draft.genre) {
                ForEach(Genre.allCases) { genre in
                    Label {
                        Text(genre.name)
                    } icon: {
                        Image(systemName: genre.symbolName)
                            .foregroundStyle(genre.tint)
                    }
                    .tag(genre)
                }
            } label: {
                Label("form.field.genre", systemImage: "tag")
            }
            .pickerStyle(.navigationLink)

            Toggle(isOn: $model.draft.isWatched.animation(.snappy)) {
                Label("form.field.watched", systemImage: "checkmark.circle")
            }

            if model.draft.isWatched {
                LabeledContent {
                    StarRatingView(rating: $model.draft.rating)
                } label: {
                    Label("form.field.rating", systemImage: "star")
                }
            }
        } header: {
            Text("form.section.details")
        }
    }

    private var notesSection: some View {
        Section {
            TextField(text: $model.draft.notes, axis: .vertical) {
                Text("form.field.notes.placeholder")
            }
            .lineLimit(3...6)
        } header: {
            Text("form.section.notes")
        }
    }

    // MARK: - Actions

    private func save() {
        guard model.save(using: MovieStore(context: modelContext)) else { return }
        dismiss()
    }
}

#Preview("New") {
    MovieFormView(route: .create)
        .modelContainer(PreviewContainer.empty)
}

#Preview("Edit") {
    MovieFormView(route: .edit(Movie(title: "Toy Story", genre: .kids, isWatched: true, rating: 4)))
        .modelContainer(PreviewContainer.populated)
}
