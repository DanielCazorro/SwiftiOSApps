//
//  AddEditItemView.swift
//  Grocery List
//
//  Created by Daniel Cazorro on 16/08/2026.
//

import SwiftUI
import SwiftData

/// Creates a new item, or edits an existing one. Edits are staged in local
/// state and only written back on save, so Cancel really cancels.
struct AddEditItemView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    private let item: Item?

    @State private var draft: Draft
    @State private var isConfirmingDelete = false
    @FocusState private var focusedField: Field?

    private enum Field: Hashable { case title, notes }

    /// The editable shape of an item, kept separate from the persisted model.
    private struct Draft {
        var title: String
        var category: GroceryCategory
        var priority: Priority
        var quantity: Int
        var unit: GroceryUnit
        var notes: String

        init(item: Item?) {
            title = item?.title ?? ""
            category = item?.category ?? .other
            priority = item?.priority ?? .medium
            quantity = item?.quantity ?? 1
            unit = item?.unit ?? .piece
            notes = item?.notes ?? ""
        }

        var trimmedTitle: String {
            title.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        var isValid: Bool { !trimmedTitle.isEmpty }
    }

    private var isEditing: Bool { item != nil }

    init(item: Item? = nil) {
        self.item = item
        _draft = State(initialValue: Draft(item: item))
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Item") {
                    TextField("Name", text: $draft.title)
                        .focused($focusedField, equals: .title)
                        .submitLabel(.done)
                        .onSubmit(save)

                    Picker("Aisle", selection: $draft.category) {
                        ForEach(GroceryCategory.allCases) { category in
                            Label(category.name, systemImage: category.symbol)
                                .tag(category)
                        }
                    }
                }

                Section("Priority") {
                    Picker("Priority", selection: $draft.priority) {
                        ForEach(Priority.allCases) { priority in
                            Text(priority.name).tag(priority)
                        }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                }

                Section("Quantity") {
                    Stepper(value: $draft.quantity, in: 1...999) {
                        LabeledContent("Amount") {
                            Text(draft.quantity, format: .number)
                                .monospacedDigit()
                                .contentTransition(.numericText())
                        }
                    }

                    Picker("Unit", selection: $draft.unit) {
                        ForEach(GroceryUnit.allCases) { unit in
                            Text(unit.name).tag(unit)
                        }
                    }
                }

                Section("Notes") {
                    TextField("Anything worth remembering", text: $draft.notes, axis: .vertical)
                        .lineLimit(3...6)
                        .focused($focusedField, equals: .notes)
                }

                if isEditing {
                    Section {
                        Button(role: .destructive) {
                            isConfirmingDelete = true
                        } label: {
                            Label("Delete item", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle(isEditing ? "Edit item" : "New item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button(isEditing ? "Save" : "Add", action: save)
                        .disabled(!draft.isValid)
                }
            }
            .confirmationDialog(
                "Delete this item?",
                isPresented: $isConfirmingDelete,
                titleVisibility: .visible
            ) {
                Button("Delete", role: .destructive, action: deleteItem)
                Button("Cancel", role: .cancel) {}
            }
            .onAppear {
                // Only auto-focus when creating; editing should not pop the
                // keyboard over content the user came to read.
                if !isEditing { focusedField = .title }
            }
        }
    }

    // MARK: - Actions

    private func save() {
        guard draft.isValid else { return }

        if let item {
            item.apply(
                title: draft.title,
                category: draft.category,
                priority: draft.priority,
                quantity: draft.quantity,
                unit: draft.unit,
                notes: draft.notes
            )
        } else {
            modelContext.insert(
                Item(
                    title: draft.trimmedTitle,
                    category: draft.category,
                    priority: draft.priority,
                    notes: draft.notes.trimmingCharacters(in: .whitespacesAndNewlines),
                    quantity: draft.quantity,
                    unit: draft.unit
                )
            )
        }

        dismiss()
    }

    private func deleteItem() {
        guard let item else { return }
        modelContext.delete(item)
        dismiss()
    }
}

#Preview("New") {
    AddEditItemView()
        .modelContainer(AppModelContainer.preview(seeded: false))
}

#Preview("Edit") {
    AddEditItemView(
        item: Item(title: "Organic milk", category: .dairy, priority: .high, notes: "Semi-skimmed", quantity: 2)
    )
    .modelContainer(AppModelContainer.preview(seeded: false))
}
