//
//  ItemRowView.swift
//  Grocery List
//
//  Created by Daniel Cazorro on 16/08/2026.
//

import SwiftUI
import SwiftData

struct ItemRowView: View {
    @Bindable var item: Item

    /// Toggling lives with the owner of the model context so the row stays a
    /// pure presentation view.
    var onToggle: () -> Void

    /// Hidden inside a section already headed by the category.
    var showsCategory: Bool = true

    var body: some View {
        HStack(spacing: 12) {
            Button(action: onToggle) {
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(item.isCompleted ? .green : .secondary)
                    .contentTransition(.symbolEffect(.replace))
            }
            .buttonStyle(.plain)
            .accessibilityLabel(item.isCompleted ? "Mark as pending" : "Mark as done")

            VStack(alignment: .leading, spacing: 3) {
                HStack(spacing: 6) {
                    Text(item.title)
                        .fontWeight(item.priority == .high && !item.isCompleted ? .semibold : .regular)
                        .strikethrough(item.isCompleted)
                        .foregroundStyle(item.isCompleted ? .secondary : .primary)

                    if item.hasMeaningfulQuantity {
                        Text(item.quantityDescription)
                            .font(.caption)
                            .monospacedDigit()
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(.fill.tertiary, in: .capsule)
                    }
                }

                if !subtitleIsEmpty {
                    HStack(spacing: 8) {
                        if showsCategory {
                            Label(item.category.name, systemImage: item.category.symbol)
                                .foregroundStyle(item.category.tint)
                        }

                        if !item.notes.isEmpty {
                            Label(item.notes, systemImage: "note.text")
                                .lineLimit(1)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .font(.caption)
                    .labelStyle(.titleAndIcon)
                }
            }

            Spacer(minLength: 0)

            if item.priority == .high && !item.isCompleted {
                Image(systemName: "exclamationmark.circle.fill")
                    .font(.caption)
                    .foregroundStyle(.red)
                    .accessibilityLabel("High priority")
            }
        }
        .padding(.vertical, 2)
        .accessibilityElement(children: .combine)
        .accessibilityValue(item.isCompleted ? Text("Completed") : Text("Pending"))
        .accessibilityAction(named: item.isCompleted ? Text("Mark as pending") : Text("Mark as done"), onToggle)
    }

    private var subtitleIsEmpty: Bool {
        !showsCategory && item.notes.isEmpty
    }
}

#Preview {
    List {
        ItemRowView(item: Item(title: "Organic milk", category: .dairy, priority: .medium, notes: "Semi-skimmed", quantity: 2), onToggle: {})
        ItemRowView(item: Item(title: "Wholewheat bread", isCompleted: true, category: .bakery, priority: .low), onToggle: {})
        ItemRowView(item: Item(title: "Salmon fillet", category: .meat, priority: .high, notes: "Wild-caught", quantity: 400, unit: .gram), onToggle: {})
        ItemRowView(item: Item(title: "Brown rice", category: .pasta, priority: .medium, quantity: 1, unit: .kilogram), onToggle: {}, showsCategory: false)
    }
    .modelContainer(AppModelContainer.preview(seeded: false))
}
