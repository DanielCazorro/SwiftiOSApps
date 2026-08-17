//
//  ItemDetailView.swift
//  Grocery List
//
//  Created by Daniel Cazorro on 16/08/2026.
//

import SwiftUI
import SwiftData

/// Read-only summary of one item, pushed from the list. Editing happens in a
/// sheet on top of it so the navigation stack stays shallow.
struct ItemDetailView: View {
    @Bindable var item: Item

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var isEditing = false
    @State private var isConfirmingDelete = false

    var body: some View {
        List {
            Section {
                header
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
            }

            Section("Details") {
                LabeledContent("Aisle") {
                    Label(item.category.name, systemImage: item.category.symbol)
                        .foregroundStyle(item.category.tint)
                }

                LabeledContent("Priority") {
                    Label(item.priority.name, systemImage: item.priority.symbol)
                        .foregroundStyle(item.priority.tint)
                }

                LabeledContent("Quantity") {
                    Text(item.quantityDescription)
                        .monospacedDigit()
                }
            }

            if !item.notes.isEmpty {
                Section("Notes") {
                    Text(item.notes)
                }
            }

            Section("Timeline") {
                LabeledContent("Added") {
                    Text(item.createdAt, format: .dateTime.day().month().year().hour().minute())
                }

                if let completedAt = item.completedAt {
                    LabeledContent("Completed") {
                        Text(completedAt, format: .dateTime.day().month().year().hour().minute())
                    }
                }
            }

            Section {
                Button {
                    withAnimation(.snappy) { item.toggleCompletion() }
                } label: {
                    Label(
                        item.isCompleted ? "Mark as pending" : "Mark as done",
                        systemImage: item.isCompleted ? "arrow.uturn.backward.circle" : "checkmark.circle"
                    )
                }

                Button(role: .destructive) {
                    isConfirmingDelete = true
                } label: {
                    Label("Delete item", systemImage: "trash")
                }
            }
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") { isEditing = true }
            }
        }
        .sheet(isPresented: $isEditing) {
            AddEditItemView(item: item)
        }
        .confirmationDialog(
            "Delete this item?",
            isPresented: $isConfirmingDelete,
            titleVisibility: .visible
        ) {
            Button("Delete", role: .destructive) {
                modelContext.delete(item)
                dismiss()
            }
            Button("Cancel", role: .cancel) {}
        }
        .completionFeedback(trigger: item.isCompleted)
    }

    private var header: some View {
        VStack(spacing: 12) {
            Image(systemName: item.category.symbol)
                .font(.system(size: 44))
                .foregroundStyle(item.category.tint)
                .frame(width: 96, height: 96)
                .background(item.category.tint.opacity(0.15), in: .circle)

            Text(item.title)
                .font(.title2.bold())
                .multilineTextAlignment(.center)

            Label(
                item.isCompleted ? "Completed" : "Pending",
                systemImage: item.isCompleted ? "checkmark.circle.fill" : "clock"
            )
            .font(.subheadline)
            .foregroundStyle(item.isCompleted ? .green : .orange)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    NavigationStack {
        ItemDetailView(
            item: Item(
                title: "Organic milk",
                category: .dairy,
                priority: .high,
                notes: "Semi-skimmed, lactose-free if they have it",
                quantity: 2
            )
        )
    }
    .modelContainer(AppModelContainer.preview(seeded: false))
}
