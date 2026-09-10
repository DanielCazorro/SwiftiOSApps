//
//  PageModel.swift
//  Pinch
//
//  Created by Daniel Cazorro on 10/09/2026.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}
