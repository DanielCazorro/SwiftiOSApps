//
//  PreferencesRepository.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import Foundation


protocol PreferencesRepository: AnyObject {
    var hasCompletedOnboarding: Bool { get set }
    var isSoundEnabled: Bool { get set }
}
