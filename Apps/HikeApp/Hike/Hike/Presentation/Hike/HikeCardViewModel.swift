//
//  HikeCardViewModel.swift
//  Hike
//
//  Created by Daniel Cazorro on 20/08/2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class HikeCardViewModel {
    // MARK: - Dependencies

    private let hikeRepository: HikeRepository
    private let favoritesRepository: FavoritesRepository
    private let locale: Locale

    // MARK: - State

    private(set) var hikes: [Hike]
    private(set) var currentIndex: Int
    private(set) var favoriteHikeIDs: Set<Hike.ID>

    private(set) var exploreCount: Int = 0

    var isShowingSettings = false

    // MARK: - Init

    init(
        hikeRepository: HikeRepository = BundledHikeRepository(),
        favoritesRepository: FavoritesRepository = UserDefaultsFavoritesRepository(),
        locale: Locale = .autoupdatingCurrent
    ) {
        self.hikeRepository = hikeRepository
        self.favoritesRepository = favoritesRepository
        self.locale = locale
        self.hikes = hikeRepository.allHikes()
        self.favoriteHikeIDs = favoritesRepository.favoriteHikeIDs()
        self.currentIndex = 0
    }

    // MARK: - Derived state

    var currentHike: Hike? {
        hikes.indices.contains(currentIndex) ? hikes[currentIndex] : nil
    }

    var isCurrentHikeFavorite: Bool {
        guard let currentHike else { return false }
        return favoriteHikeIDs.contains(currentHike.id)
    }

    var canExplore: Bool { hikes.count > 1 }

    func formatDistance(_ distance: Measurement<UnitLength>) -> String {
        distance.formatted(
            .measurement(width: .abbreviated, usage: .road).locale(locale)
        )
    }

    func formatElevationGain(_ elevation: Measurement<UnitLength>) -> String {
        let unit: UnitLength = locale.measurementSystem == .metric ? .meters : .feet
        return elevation.converted(to: unit).formatted(
            .measurement(
                width: .abbreviated,
                usage: .asProvided,
                numberFormatStyle: .number.precision(.fractionLength(0))
            )
            .locale(locale)
        )
    }

    // MARK: - Intents

    func showAnotherHike() {
        guard canExplore else { return }
        let offset = Int.random(in: 1..<hikes.count)
        currentIndex = (currentIndex + offset) % hikes.count
        exploreCount += 1
    }

    func toggleFavorite() {
        guard let currentHike else { return }
        let shouldBeFavorite = !favoriteHikeIDs.contains(currentHike.id)

        favoritesRepository.setFavorite(shouldBeFavorite, forHikeID: currentHike.id)

        if shouldBeFavorite {
            favoriteHikeIDs.insert(currentHike.id)
        } else {
            favoriteHikeIDs.remove(currentHike.id)
        }
    }

    func showSettings() {
        isShowingSettings = true
    }
}
