//
//  SettingsView.swift
//  Fruits
//
//  Created by Daniel Cazorro on 30/09/2026.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(OnboardingStore.self) private var onboardingStore
    @State private var isRestartRequested = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    aboutSection
                    customizationSection
                    applicationSection
                }
                .padding()
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .close) {
                        dismiss()
                    }
                }
            }
        }
        .onChange(of: isRestartRequested) { _, isRequested in
            if isRequested {
                dismiss()
            }
        }
        .onDisappear {
            if isRestartRequested {
                onboardingStore.restart()
            }
        }
    }

    private var aboutSection: some View {
        GroupBox {
            Divider()
                .padding(.vertical, 4)

            HStack(spacing: 10) {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .clipShape(.rect(cornerRadius: 9))
                    .accessibilityHidden(true)

                Text("Most fruits are naturally low in fat, sodium, and calories. None have cholesterol. Fruits are sources of vitamins, minerals, and antioxidants.")
                    .font(.footnote)
            }
        } label: {
            SettingsLabelView(title: "Fruits", systemImage: "info.circle")
        }
    }

    private var customizationSection: some View {
        GroupBox {
            Divider()
                .padding(.vertical, 4)

            Text("If you wish, you can restart the application by toggling the switch in this box. That way it starts the onboarding process and you will see the welcome screen again.")
                .padding(.vertical, 8)
                .frame(minHeight: 60)
                .layoutPriority(1)
                .font(.footnote)

            Toggle(isOn: $isRestartRequested) {
                (isRestartRequested ? Text("Restarted") : Text("Restart"))
                    .fontWeight(.bold)
                    .textCase(.uppercase)
                    .foregroundStyle(isRestartRequested ? Color.green : Color.secondary)
            }
            .padding()
            .background(Color(.tertiarySystemBackground), in: .rect(cornerRadius: 8))
        } label: {
            SettingsLabelView(title: "Customization", systemImage: "paintbrush")
        }
    }

    private var applicationSection: some View {
        GroupBox {
            SettingsRowView(name: "Developer", linkLabel: "GitHub", destination: ExternalLink.developer)
            SettingsRowView(name: "Source code", linkLabel: "SwiftiOSApps", destination: ExternalLink.sourceCode)
            SettingsRowView(name: "Compatibility", content: "iOS \(Bundle.main.minimumOSVersion)")
            SettingsRowView(name: "Version", content: Bundle.main.appVersion)
        } label: {
            SettingsLabelView(title: "Application", systemImage: "apps.iphone")
        }
    }
}

#Preview {
    SettingsView()
        .environment(OnboardingStore())
        .preferredColorScheme(.dark)
}
