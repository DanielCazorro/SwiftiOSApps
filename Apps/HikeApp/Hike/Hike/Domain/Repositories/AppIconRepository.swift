//
//  AppIconRepository.swift
//  Hike
//
//  Created by Daniel Cazorro on 23/08/2026.
//

import Foundation

@MainActor
protocol AppIconRepository {
    var supportsAlternateIcons: Bool { get }
    var currentIcon: AppIcon { get }
    func setIcon(_ icon: AppIcon) async throws
}
