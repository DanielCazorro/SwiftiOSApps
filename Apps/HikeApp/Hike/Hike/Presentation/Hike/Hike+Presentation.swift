//
//  Hike+Presentation.swift
//  Hike
//
//  Created by Daniel Cazorro on 20/08/2026.
//

import SwiftUI

extension Hike {
    var name: LocalizedStringKey { LocalizedStringKey(nameKey) }
    var location: LocalizedStringKey { LocalizedStringKey(locationKey) }
    var localizedName: String { String(localized: .init(stringLiteral: nameKey)) }
}

extension HikeDifficulty {
    var label: LocalizedStringKey { LocalizedStringKey(localizationKey) }
    var localizedName: String { String(localized: .init(stringLiteral: localizationKey)) }
}

extension AppIcon {
    var displayName: LocalizedStringKey { LocalizedStringKey(localizationKey) }
    var localizedName: String { String(localized: .init(stringLiteral: localizationKey)) }
}
