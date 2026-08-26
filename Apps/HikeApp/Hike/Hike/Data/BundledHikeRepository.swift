//
//  BundledHikeRepository.swift
//  Hike
//
//  Created by Daniel Cazorro on 20/08/2026.
//

import Foundation

struct BundledHikeRepository: HikeRepository {
    private static let hikes: [Hike] = [
        Hike(
            id: 1,
            imageName: "image-1",
            nameKey: "hike.1.name",
            locationKey: "hike.1.location",
            distanceInKilometers: 7.7,
            elevationGainInMeters: 105,
            difficulty: .easy
        ),
        Hike(
            id: 2,
            imageName: "image-2",
            nameKey: "hike.2.name",
            locationKey: "hike.2.location",
            distanceInKilometers: 22.0,
            elevationGainInMeters: 320,
            difficulty: .moderate
        ),
        Hike(
            id: 3,
            imageName: "image-3",
            nameKey: "hike.3.name",
            locationKey: "hike.3.location",
            distanceInKilometers: 11.5,
            elevationGainInMeters: 1_050,
            difficulty: .challenging
        ),
        Hike(
            id: 4,
            imageName: "image-4",
            nameKey: "hike.4.name",
            locationKey: "hike.4.location",
            distanceInKilometers: 8.3,
            elevationGainInMeters: 400,
            difficulty: .moderate
        ),
        Hike(
            id: 5,
            imageName: "image-5",
            nameKey: "hike.5.name",
            locationKey: "hike.5.location",
            distanceInKilometers: 17.0,
            elevationGainInMeters: 1_400,
            difficulty: .challenging
        )
    ]

    func allHikes() -> [Hike] { Self.hikes }
}
