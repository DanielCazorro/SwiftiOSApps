//
//  PreviewSupport.swift
//  Grocery List
//
//  Created by Daniel Cazorro on 16/08/2026.
//

import Foundation

extension UserDefaults {
    /// Scratch defaults so previews never write into the real app preferences.
    static let previewDefaults: UserDefaults = {
        let suite = UserDefaults(suiteName: "com.grocerylist.previews") ?? .standard
        suite.removePersistentDomain(forName: "com.grocerylist.previews")
        return suite
    }()
}
