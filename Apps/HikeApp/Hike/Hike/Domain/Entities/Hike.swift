//
//  Hike.swift
//  Hike
//
//  Created by Daniel Cazorro on 20/08/2026.
//

import Foundation

struct Hike: Identifiable, Hashable, Sendable {
    let id: Int
    let imageName: String
    let nameKey: String
    let locationKey: String
    let distance: Measurement<UnitLength>
    let elevationGain: Measurement<UnitLength>
    let difficulty: HikeDifficulty
}

extension Hike {
    init(
        id: Int,
        imageName: String,
        nameKey: String,
        locationKey: String,
        distanceInKilometers: Double,
        elevationGainInMeters: Double,
        difficulty: HikeDifficulty
    ) {
        self.init(
            id: id,
            imageName: imageName,
            nameKey: nameKey,
            locationKey: locationKey,
            distance: Measurement(value: distanceInKilometers, unit: .kilometers),
            elevationGain: Measurement(value: elevationGainInMeters, unit: .meters),
            difficulty: difficulty
        )
    }
}
