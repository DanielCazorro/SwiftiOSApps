//
//  FilterView.swift
//  Grocery List
//
//  Created by Daniel Cazorro on 16/08/2026.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: GroceryListViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section("Aisle") {
                    Picker("Aisle", selection: $viewModel.selectedCategory) {
                        Text("All aisles").tag(GroceryCategory?.none)
                        ForEach(GroceryCategory.allCases) { category in
                            Label(category.name, systemImage: category.symbol)
                                .tag(GroceryCategory?.some(category))
                        }
                    }
                    .pickerStyle(.navigationLink)
                }

                Section("Priority") {
                    Picker("Priority", selection: $viewModel.selectedPriority) {
                        Text("Any").tag(Priority?.none)
                        ForEach(Priority.allCases) { priority in
                            Text(priority.name).tag(Priority?.some(priority))
                        }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                }

                Section {
                    Toggle("Show completed", isOn: $viewModel.showCompletedItems)
                } footer: {
                    Text("Hide items you have already ticked off to keep the list short while shopping.")
                }

                Section("Sort by") {
                    Picker("Sort by", selection: $viewModel.sortOption) {
                        ForEach(GroceryListViewModel.SortOption.allCases) { option in
                            Label(option.name, systemImage: option.symbol)
                                .tag(option)
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                }

                if viewModel.isFilterActive {
                    Section {
                        Button("Reset \(viewModel.activeFilterCount) filters", role: .destructive) {
                            withAnimation { viewModel.resetFilters() }
                        }
                    }
                }
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    FilterView(viewModel: GroceryListViewModel(defaults: .previewDefaults))
}
