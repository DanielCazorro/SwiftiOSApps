//
//  GuideView.swift
//  Pinch
//
//  Created by Daniel Cazorro on 10/09/2026.
//

import SwiftUI

struct GuideView: View {
    @Bindable var settings: AppSettings

    @Environment(\.dismiss) private var dismiss

    private struct Gesture: Identifiable {
        let id = UUID()
        let icon: String
        let title: LocalizedStringKey
        let message: LocalizedStringKey
    }

    private let gestures: [Gesture] = [
        Gesture(icon: "hand.pinch", title: "guide.pinch.title", message: "guide.pinch.message"),
        Gesture(icon: "hand.tap", title: "guide.doubletap.title", message: "guide.doubletap.message"),
        Gesture(icon: "hand.draw", title: "guide.drag.title", message: "guide.drag.message"),
        Gesture(icon: "arrow.left.arrow.right", title: "guide.swipe.title", message: "guide.swipe.message"),
        Gesture(icon: "photo.stack", title: "guide.drawer.title", message: "guide.drawer.message")
    ]

    var body: some View {
        NavigationStack {
            List {
                Section("guide.section.gestures") {
                    ForEach(gestures) { gesture in
                        row(for: gesture)
                    }
                }

                Section("guide.section.settings") {
                    Toggle("guide.settings.haptics", isOn: $settings.isHapticsEnabled)
                }

                Section("guide.section.about") {
                    Text("guide.about.summary")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    LabeledContent("guide.about.developer", value: AppInfo.author)
                    LabeledContent("guide.about.version", value: AppInfo.fullVersion)
                }
            }
            .navigationTitle("guide.title")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("guide.done") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }

    private func row(for gesture: Gesture) -> some View {
        Label {
            VStack(alignment: .leading, spacing: 2) {
                Text(gesture.title)
                    .font(.body.weight(.medium))
                Text(gesture.message)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        } icon: {
            Image(systemName: gesture.icon)
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(Color.accentColor)
                .font(.title3)
                .frame(width: 28)
        }
        .padding(.vertical, 2)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    GuideView(settings: AppDependencies.preview.settings)
        .preferredColorScheme(.dark)
}
