//
//  SettingsView.swift
//  Hike
//
//  Created by Daniel Cazorro on 23/08/2026.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - Properties
    private let alternateAppIcons: [String] = [
        "AppIcon-MagnifyingGlass",
        "AppIcon-Map",
        "AppIcon-Mushroom",
        "AppIcon-Camera",
        "AppIcon-Backpack",
        "AppIcon-Campfire"
    ]

    var body: some View {
        List {
            // MARK: - Section: Header
            Section {
                HStack {
                    Spacer()
                    Image(systemName: "laurel.leading")
                        .font(.system(size: 80, weight: .black))

                    VStack(spacing: -10) {
                        Text("Hike")
                            .font(.system(size: 66, weight: .black))

                        Text("Editors' Choice")
                    }

                    Image(systemName: "laurel.trailing")
                        .font(.system(size: 80, weight: .black))
                    Spacer()
                }
                .foregroundStyle(
                    LinearGradient(
                        colors: [.customGreenLight, .customGreenMedium, .customGreenDark],
                        startPoint: .top,
                        endPoint: .bottom)
                )
                .padding(.top, 8)

                VStack(spacing: 8) {
                    Text("Where can you find \nperfect tracs?")
                        .font(.title2)
                        .fontWeight(.heavy)

                    Text("The hike which looks gorgeus in photos but is even better once you are actually there. The hike that you hope to do again someday. \nFind the best day hikes in the app")
                        .font(.footnote)
                        .italic()

                    Text("Dust off the boots! It's time for a walk.")
                        .fontWeight(.heavy)
                        .foregroundColor(.customGreenMedium)
                }
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
                .frame(maxWidth: .infinity)
            } //: Header
            .listRowSeparator(.hidden)

            // MARK: - Section: Icons
            Section(header: Text("Alternate Icons")) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(alternateAppIcons.indices, id: \.self) { item in
                            Button {
                                print("Icon \(alternateAppIcons[item]) was pressed.")

                                UIApplication.shared.setAlternateIconName(alternateAppIcons[item]) { error in
                                    if error != nil {
                                        print("Failed request to update the app's icon: \(String(describing: error?.localizedDescription))")
                                    } else {
                                        print("Success! Yo have changed teh app's icon to \(alternateAppIcons[item])")
                                    }
                                }
                            } label: {
                                Image("\(alternateAppIcons[item])-Preview")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(16)
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                } // : Scrool View
                .padding(.top, 12)

                Text("Choose your favourite app icon from the collection above.")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .font(.footnote)
                    .padding(.bottom, 12)
            } // : Section
            .listRowSeparator(.hidden)

            // MARK: - Section: About
            Section(
                header: Text("ABOUT THE APP"),
                footer: HStack {
                    Spacer()
                    Text("Copyright All right reserved")
                    Spacer()
                }
                    .padding(.vertical, 8)
            ) {
                // 2. Basic Labeled Conent
                // LabeledContent("Application", value: "Hike")

                // 2. Advanced Labeled Content
                CustomListRowView(
                    rowLabel: "Application",
                    rowIcon: "apps.iphone",
                    rowContent: "HIKE",
                    rowTintColor: .blue
                )

                CustomListRowView(
                    rowLabel: "Compatibility",
                    rowIcon: "info.circle",
                    rowContent: "iOS, iPadOS",
                    rowTintColor: .red
                )

                CustomListRowView(
                    rowLabel: "Technology",
                    rowIcon: "swift",
                    rowContent: "Swift",
                    rowTintColor: .orange
                )

                CustomListRowView(
                    rowLabel: "Version",
                    rowIcon: "gear",
                    rowContent: "1.0",
                    rowTintColor: .purple
                )

                CustomListRowView(
                    rowLabel: "Developer",
                    rowIcon: "ellipsis.curlybraces",
                    rowContent: "Jhn Doe",
                    rowTintColor: .mint
                )

                CustomListRowView(
                    rowLabel: "Designer",
                    rowIcon: "paintpalette",
                    rowContent: "Robert Petras",
                    rowTintColor: .pink
                )

                CustomListRowView(
                    rowLabel: "Website",
                    rowIcon: "globe",
                    rowTintColor: .indigo,
                    rowLinkLabel: "Credo Academy",
                    rowLinkDestination: "https://credo.academy"
                )
            } // : Section
        } // : List
    }
}

#Preview {
    SettingsView()
}
