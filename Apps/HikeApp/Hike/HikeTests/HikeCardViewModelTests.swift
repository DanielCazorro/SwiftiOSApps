//
//  HikeCardViewModelTests.swift
//  HikeTests
//
//  Created by Daniel Cazorro on 26/08/2026.
//

import Foundation
import Testing
@testable import Hike

@MainActor
@Suite("Hike card view model")
struct HikeCardViewModelTests {
    private func makeViewModel(
        hikeCount: Int = 5,
        defaults: UserDefaults? = nil,
        locale: Locale = Locale(identifier: "es_ES")
    ) -> HikeCardViewModel {
        HikeCardViewModel(
            hikeRepository: StubHikeRepository(count: hikeCount),
            favoritesRepository: UserDefaultsFavoritesRepository(
                defaults: defaults ?? .makeEphemeral()
            ),
            locale: locale
        )
    }

    // MARK: - Selecting trails

    @Test("Starts on the first trail")
    func startsOnFirstTrail() {
        let viewModel = makeViewModel()
        #expect(viewModel.currentHike?.id == 1)
        #expect(viewModel.canExplore)
    }

    @Test("Exploring never lands on the trail already shown", .timeLimit(.minutes(1)))
    func exploringNeverRepeats() {
        let viewModel = makeViewModel()

        for _ in 0..<500 {
            let previous = viewModel.currentHike
            viewModel.showAnotherHike()
            #expect(viewModel.currentHike != previous)
        }
    }

    @Test("Exploring can reach every trail")
    func exploringReachesEveryTrail() {
        let viewModel = makeViewModel(hikeCount: 5)
        var seen: Set<Int> = [viewModel.currentHike!.id]

        for _ in 0..<500 {
            viewModel.showAnotherHike()
            seen.insert(viewModel.currentHike!.id)
        }

        #expect(seen == Set(1...5))
    }

    @Test("A single trail leaves exploring disabled and inert")
    func singleTrailCannotExplore() {
        let viewModel = makeViewModel(hikeCount: 1)

        #expect(!viewModel.canExplore)
        viewModel.showAnotherHike()

        #expect(viewModel.currentHike?.id == 1)
        #expect(viewModel.exploreCount == 0)
    }

    @Test("An empty catalog degrades to the placeholder instead of crashing")
    func emptyCatalogHasNoCurrentHike() {
        let viewModel = makeViewModel(hikeCount: 0)

        #expect(viewModel.currentHike == nil)
        #expect(!viewModel.canExplore)

        // Neither intent has anything to act on, and neither may trap.
        viewModel.showAnotherHike()
        viewModel.toggleFavorite()

        #expect(!viewModel.isCurrentHikeFavorite)
    }

    // MARK: - Favorites

    @Test("Toggling a favorite flips the flag both ways")
    func toggleFavorite() {
        let viewModel = makeViewModel()
        #expect(!viewModel.isCurrentHikeFavorite)

        viewModel.toggleFavorite()
        #expect(viewModel.isCurrentHikeFavorite)

        viewModel.toggleFavorite()
        #expect(!viewModel.isCurrentHikeFavorite)
    }

    @Test("Favorites survive a new view model over the same storage")
    func favoritesPersist() {
        let defaults = UserDefaults.makeEphemeral()

        let first = makeViewModel(defaults: defaults)
        first.toggleFavorite()
        let favoriteID = first.currentHike!.id

        let second = makeViewModel(defaults: defaults)
        #expect(second.favoriteHikeIDs.contains(favoriteID))
        #expect(second.isCurrentHikeFavorite)
    }

    @Test("Favorites are tracked per trail")
    func favoritesAreScopedToTheTrail() {
        let viewModel = makeViewModel()
        viewModel.toggleFavorite()
        let favoriteID = viewModel.currentHike!.id

        viewModel.showAnotherHike()
        #expect(!viewModel.isCurrentHikeFavorite)
        #expect(viewModel.favoriteHikeIDs == [favoriteID])
    }

    // MARK: - Formatting

    @Test("Distance follows the locale's measurement system")
    func distanceFormatting() {
        let metric = makeViewModel(locale: Locale(identifier: "es_ES"))
        let imperial = makeViewModel(locale: Locale(identifier: "en_US"))

        let distance = Measurement(value: 7.7, unit: UnitLength.kilometers)
        #expect(metric.formatDistance(distance).contains("km"))
        #expect(imperial.formatDistance(distance).contains("mi"))
    }

    @Test("Elevation keeps its unit instead of being promoted to kilometres")
    func elevationFormatting() {
        let metric = makeViewModel(locale: Locale(identifier: "es_ES"))
        let imperial = makeViewModel(locale: Locale(identifier: "en_US"))

        let climb = Measurement(value: 1_050, unit: UnitLength.meters)
        let metricText = metric.formatElevationGain(climb)

        #expect(metricText.contains("m"))
        #expect(!metricText.contains("km"))
        #expect(imperial.formatElevationGain(climb).contains("ft"))
    }

    @Test("Elevation is not rounded away")
    func elevationIsNotRounded() {
        let viewModel = makeViewModel(locale: Locale(identifier: "es_ES"))
        let climb = Measurement(value: 105, unit: UnitLength.meters)

        #expect(viewModel.formatElevationGain(climb).contains("105"))
    }
}
