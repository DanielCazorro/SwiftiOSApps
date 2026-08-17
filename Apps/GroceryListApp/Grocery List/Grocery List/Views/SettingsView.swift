//
//  SettingsView.swift
//  Grocery List
//
//  Created by Daniel Cazorro on 16/08/2026.
//

import SwiftUI
import SwiftData
import UIKit

/// Display preferences, TipKit controls and app info.
struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Environment(\.openURL) private var openURL

    @Bindable var viewModel: GroceryListViewModel

    @Query private var items: [Item]

    @State private var didResetTips = false
    @State private var isConfirmingClearAll = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Display") {
                    Toggle(isOn: $viewModel.groupByCategory) {
                        Label("Group by aisle", systemImage: "square.stack.3d.up")
                    }

                    Toggle(isOn: $viewModel.showCompletedItems) {
                        Label("Show completed", systemImage: "checkmark.circle")
                    }

                    Picker(selection: $viewModel.sortOption) {
                        ForEach(GroceryListViewModel.SortOption.allCases) { option in
                            Text(option.name).tag(option)
                        }
                    } label: {
                        Label("Sort by", systemImage: "arrow.up.arrow.down")
                    }
                }

                Section {
                    Button {
                        TipsConfiguration.reset()
                        didResetTips = true
                    } label: {
                        Label("Show tips again", systemImage: "lightbulb")
                    }
                    .disabled(didResetTips)
                } header: {
                    Text("Tips")
                } footer: {
                    Text(didResetTips
                         ? "Tips will reappear the next time you launch the app."
                         : "Bring back the hints you have already dismissed.")
                }

                Section("Language") {
                    LabeledContent("App language") {
                        Text(Locale.current.localizedString(forIdentifier: Locale.current.identifier) ?? Locale.current.identifier)
                    }

                    Button {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            openURL(url)
                        }
                    } label: {
                        Label("Change in iOS Settings", systemImage: "globe")
                    }
                }

                Section {
                    Button {
                        addStarterList()
                    } label: {
                        Label("Add a starter list", systemImage: "sparkles")
                    }

                    Button(role: .destructive) {
                        isConfirmingClearAll = true
                    } label: {
                        // A destructive role tints the title but not the icon.
                        Label("Delete all items", systemImage: "trash")
                            .foregroundStyle(.red)
                    }
                    .disabled(items.isEmpty)
                } header: {
                    Text("Data")
                } footer: {
                    Text("\(items.count) items stored on this device.")
                }

                Section("About") {
                    LabeledContent("Version", value: Self.versionString)
                    LabeledContent("Built with", value: "SwiftUI · SwiftData · TipKit · Charts")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
            .confirmationDialog(
                "Delete everything?",
                isPresented: $isConfirmingClearAll,
                titleVisibility: .visible
            ) {
                Button("Delete \(items.count) items", role: .destructive) {
                    for item in items { modelContext.delete(item) }
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }

    private func addStarterList() {
        for item in Item.sampleList() {
            modelContext.insert(item)
        }
        dismiss()
    }

    private static var versionString: String {
        let info = Bundle.main.infoDictionary
        let short = info?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = info?["CFBundleVersion"] as? String ?? "1"
        return "\(short) (\(build))"
    }
}

#Preview {
    SettingsView(viewModel: GroceryListViewModel(defaults: .previewDefaults))
        .modelContainer(AppModelContainer.preview())
}
