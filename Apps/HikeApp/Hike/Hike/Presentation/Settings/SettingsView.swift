//
//  SettingsView.swift
//  Hike
//
//  Created by Daniel Cazorro on 23/08/2026.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var viewModel = SettingsViewModel()

    var body: some View {
        NavigationStack {
            List {
                headerSection
                iconsSection
                aboutSection
            }
            .navigationTitle(Text("settings.title"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("settings.done") { dismiss() }
                }
            }
            .alert(
                Text("settings.icons.error.title"),
                isPresented: $viewModel.isPresentingIconError,
                presenting: viewModel.iconChangeErrorMessage
            ) { _ in
                Button("settings.ok", role: .cancel) {}
            } message: { message in
                Text(message)
            }
        }
    }

    // MARK: - Header

    private var headerSection: some View {
        Section {
            HStack(spacing: 4) {
                Spacer(minLength: 0)

                Image(systemName: "laurel.leading")
                    .font(.system(size: 72, weight: .black))

                VStack(spacing: -10) {
                    Text("settings.appName")
                        .font(.system(size: 60, weight: .black))
                    Text("settings.editorsChoice")
                }

                Image(systemName: "laurel.trailing")
                    .font(.system(size: 72, weight: .black))

                Spacer(minLength: 0)
            }
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .foregroundStyle(
                .hikeVertical([.customGreenLight, .customGreenMedium, .customGreenDark])
            )
            .padding(.top, 8)
            .accessibilityElement(children: .combine)

            VStack(spacing: 8) {
                Text("settings.headline")
                    .font(.title2.weight(.heavy))

                Text("settings.body")
                    .font(.footnote)
                    .italic()

                Text("settings.callToAction")
                    .fontWeight(.heavy)
                    .foregroundStyle(Color.customGreenMedium)
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .padding(.bottom, 16)
        }
        .listRowSeparator(.hidden)
    }

    // MARK: - Alternate icons

    private var iconsSection: some View {
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.icons) { icon in
                        iconButton(for: icon)
                    }
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 2)
            }
            .padding(.top, 12)
            .disabled(!viewModel.supportsAlternateIcons)
            .opacity(viewModel.supportsAlternateIcons ? 1 : 0.4)

            Text(viewModel.supportsAlternateIcons ? "settings.icons.footer" : "settings.icons.unsupported")
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .font(.footnote)
                .padding(.bottom, 12)
        } header: {
            Text("settings.section.icons")
        }
        .listRowSeparator(.hidden)
    }

    private func iconButton(for icon: AppIcon) -> some View {
        let isSelected = viewModel.selectedIcon == icon

        return Button {
            Task { await viewModel.selectIcon(icon) }
        } label: {
            Image(icon.previewImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(.rect(cornerRadius: 16, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .strokeBorder(Color.accentColor, lineWidth: isSelected ? 3 : 0)
                }
                .overlay(alignment: .bottomTrailing) {
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title3)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white, Color.accentColor)
                            .padding(4)
                            .transition(.scale.combined(with: .opacity))
                    }
                }
                .animation(.snappy, value: isSelected)
        }
        .buttonStyle(.borderless)
        .accessibilityLabel(Text(icon.displayName))
        .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : .isButton)
    }

    // MARK: - About

    private var aboutSection: some View {
        Section {
            SettingsRowView(
                titleKey: "settings.about.application",
                systemImage: "apps.iphone",
                tint: .blue,
                value: AppInfo.name
            )

            SettingsRowView(
                titleKey: "settings.about.compatibility",
                systemImage: "info.circle",
                tint: .red,
                value: "iOS, iPadOS"
            )

            SettingsRowView(
                titleKey: "settings.about.technology",
                systemImage: "swift",
                tint: .orange,
                value: "SwiftUI"
            )

            SettingsRowView(
                titleKey: "settings.about.version",
                systemImage: "gear",
                tint: .purple,
                value: viewModel.appVersion
            )

            SettingsRowView(
                titleKey: "settings.about.developer",
                systemImage: "ellipsis.curlybraces",
                tint: .mint,
                value: AppInfo.author
            )

            SettingsRowView(
                titleKey: "settings.about.design",
                systemImage: "paintpalette",
                tint: .pink,
                value: AppInfo.author
            )

            SettingsRowView(
                titleKey: "settings.about.contact",
                systemImage: "envelope",
                tint: .indigo,
                linkTitle: AppInfo.contactEmail,
                destination: AppLinks.contact
            )
        } header: {
            Text("settings.section.about")
        } footer: {
            Text("settings.about.copyright \(AppInfo.currentYear) \(AppInfo.author)")
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding(.vertical, 8)
        }
    }
}

#Preview {
    SettingsView()
}

#Preview("Español") {
    SettingsView()
        .environment(\.locale, Locale(identifier: "es"))
}
