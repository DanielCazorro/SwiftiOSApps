//
//  HikeRepository.swift
//  Hike
//
//  Created by Daniel Cazorro on 20/08/2026.
//

import Foundation

protocol HikeRepository: Sendable {
    func allHikes() -> [Hike]
}
