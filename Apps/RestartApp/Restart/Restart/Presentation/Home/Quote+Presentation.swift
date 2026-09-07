//
//  Quote+Presentation.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import SwiftUI

extension Quote {
    var text: LocalizedStringKey { LocalizedStringKey(textKey) }
    var author: LocalizedStringKey { LocalizedStringKey(authorKey) }
    var localizedText: String { String(localized: .init(stringLiteral: textKey)) }
    var localizedAuthor: String { String(localized: .init(stringLiteral: authorKey)) }
    var shareMessage: String { "“\(localizedText)” — \(localizedAuthor)" }
}
