//
//  SettingsView.swift
//  Fruits
//
//  Created by Daniel Cazorro on 30/09/2026.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isOnboarding") var isOnboarding = false

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    // MARK: - Section 1
                    GroupBox(
                        label:
                            SettingsLabelView(labelText: "Fructus", labelImage: "info.circle")
                    ) {
                        Divider().padding(.vertical, 4)
                        HStack(alignment: .center, spacing: 10) {
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .cornerRadius(9)

                            Text("Most fruits are naturally low in fat, sodium, and calories. None have cholesterol. Fruits are sources of vitamins, minerals, and antioxidants.")
                                .font(.footnote)
                        }
                    }

                    // MARK: - Section 2

                    GroupBox(
                        label: SettingsLabelView(labelText: "Customization", labelImage: "paintbrush")
                    ) {
                        Divider().padding(.vertical, 4)

                        Text("If you wish, you can resstart the application by toggle the switch in this box. That way it starts the onboarding process and you will see the welcome screen again.")
                            .padding(.vertical, 8)
                            .frame(minHeight: 60)
                            .layoutPriority(1)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)

                        Toggle(isOn: $isOnboarding) {
                            if isOnboarding {
                                Text("Restarted".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundStyle(.green)
                            }
                            else {
                                Text("Restart".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding()
                        .background(
                            Color(UIColor.tertiarySystemBackground)
                                .clipShape(
                                    RoundedRectangle(
                                        cornerRadius: 8,
                                        style: .continuous
                                    )
                                )
                        )
                    }

                    // MARK: - Section 3
                    GroupBox(
                        label: SettingsLabelView(labelText: "Application", labelImage: "apps.iphone")
                    ) {

                        SettingsRowView(
                            name: "Developer",
                            content: "Dani"
                        )
                        SettingsRowView(name: "Designer", content: "Daniel")
                        SettingsRowView(name: "Compatibility", content: "iOS 27.0")
                        SettingsRowView(
                            name: "Website",
                            linkLabel: "SwiftUI Masterclass",
                            linkDestination: "swiftuimasterclass.com"
                        )
                        SettingsRowView(
                            name: "Twitter",
                            linkLabel: "@DanielCazorro",
                            linkDestination: "twitter.com/danielcazorro"
                        )
                        SettingsRowView(name: "SwiftUI", content: "2.0")
                        SettingsRowView(name: "Version", content: "1.1.0")
                    } // Box

                } // VStack
                .navigationTitle(Text("Settings"))
                .navigationBarTitleDisplayMode(.large)
                .navigationBarItems(
                    trailing:
                        Button(action: {presentationMode.wrappedValue.dismiss()}) {
                            Image(systemName: "xmark")
                        }
                )
                .padding()
            } // Scrool
        } // Navigation

    }
}

#Preview {
    SettingsView()
        .preferredColorScheme(.dark)
}
