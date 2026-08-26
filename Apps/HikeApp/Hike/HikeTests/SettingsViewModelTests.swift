//
//  SettingsViewModelTests.swift
//  HikeTests
//
//  Created by Daniel Cazorro on 26/08/2026.
//

import Foundation
import Testing
import UIKit
@testable import Hike

@MainActor
@Suite("Settings view model")
struct SettingsViewModelTests {
    @Test("The picker starts on the icon the system reports")
    func startsOnInstalledIcon() {
        let repository = StubAppIconRepository(currentIcon: .campfire)
        let viewModel = SettingsViewModel(appIconRepository: repository)

        #expect(viewModel.selectedIcon == .campfire)
    }

    @Test("Selecting an icon updates the selection and the system")
    func selectIcon() async {
        let repository = StubAppIconRepository()
        let viewModel = SettingsViewModel(appIconRepository: repository)

        await viewModel.selectIcon(.map)

        #expect(viewModel.selectedIcon == .map)
        #expect(repository.currentIcon == .map)
        #expect(viewModel.iconChangeErrorMessage == nil)
    }

    @Test("Re-selecting the current icon does not call the system")
    func reselectingIsANoOp() async {
        let repository = StubAppIconRepository(currentIcon: .map)
        let viewModel = SettingsViewModel(appIconRepository: repository)

        await viewModel.selectIcon(.map)

        #expect(repository.setIconCallCount == 0)
    }

    @Test("A rejected icon change rolls the selection back and surfaces the reason")
    func failureRollsBack() async {
        let repository = StubAppIconRepository(currentIcon: .primary)
        repository.errorToThrow = StubError(errorDescription: "Not allowed")
        let viewModel = SettingsViewModel(appIconRepository: repository)

        await viewModel.selectIcon(.mushroom)

        #expect(viewModel.selectedIcon == .primary)
        #expect(viewModel.iconChangeErrorMessage == "Not allowed")
        #expect(viewModel.isPresentingIconError)
    }

    @Test("Dismissing the alert clears the error")
    func dismissingAlertClearsError() async {
        let repository = StubAppIconRepository()
        repository.errorToThrow = StubError(errorDescription: "Not allowed")
        let viewModel = SettingsViewModel(appIconRepository: repository)

        await viewModel.selectIcon(.camera)
        viewModel.isPresentingIconError = false

        #expect(viewModel.iconChangeErrorMessage == nil)
    }

    @Test("Alternate icon support is reported from the repository")
    func reportsSupport() {
        let unsupported = StubAppIconRepository(supportsAlternateIcons: false)
        #expect(!SettingsViewModel(appIconRepository: unsupported).supportsAlternateIcons)
    }
}

@Suite("App icon")
struct AppIconTests {
    @Test("The primary icon maps to nil, which is what UIKit expects")
    func primaryIconUsesNil() {
        #expect(AppIcon.primary.alternateIconName == nil)
        #expect(AppIcon(alternateIconName: nil) == .primary)
    }

    @Test("Every alternate icon round-trips through its UIKit name", arguments: AppIcon.allCases)
    func roundTrip(icon: AppIcon) {
        #expect(AppIcon(alternateIconName: icon.alternateIconName) == icon)
    }

    @Test("An unknown name falls back to the primary icon rather than trapping")
    func unknownNameFallsBack() {
        #expect(AppIcon(alternateIconName: "AppIcon-DoesNotExist") == .primary)
    }

    @Test("Every icon has a preview image in the asset catalog", arguments: AppIcon.allCases)
    func previewImageExists(icon: AppIcon) {
        #expect(
            UIImage(named: icon.previewImageName, in: .main, compatibleWith: nil) != nil,
            "Missing image set \(icon.previewImageName)"
        )
    }
}
