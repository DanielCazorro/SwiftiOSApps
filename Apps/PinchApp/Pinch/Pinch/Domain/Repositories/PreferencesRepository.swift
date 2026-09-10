//
//  PreferencesRepository.swift
//  Pinch
//
//  Created by Daniel Cazorro on 10/09/2026.
//

protocol PreferencesRepository: AnyObject {
    var lastPageID: Int? { get set }
    var isHapticsEnabled: Bool { get set }
    var hasSeenGuide: Bool { get set }
}
