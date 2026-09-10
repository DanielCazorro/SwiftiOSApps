//
//  Page+Presentation.swift
//  Pinch
//
//  Created by Daniel Cazorro on 10/09/2026.
//

import SwiftUI

extension Page {
    var title: LocalizedStringKey { LocalizedStringKey(titleKey) }
    var caption: LocalizedStringKey { LocalizedStringKey(captionKey) }
    var image: Image { Image(imageName) }
    var thumbnail: Image { Image(thumbnailName) }
}

enum ViewerStrings {
    static func pagePosition(_ index: Int, of count: Int) -> String {
        String(format: String(localized: "viewer.page.position"), index, count)
    }

    static func zoomPercentage(_ percentage: Int) -> String {
        String(format: String(localized: "viewer.zoom.value"), percentage)
    }
}
