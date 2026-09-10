//
//  Page.swift
//  Pinch
//
//  Created by Daniel Cazorro on 10/09/2026.
//

import CoreGraphics

struct Page: Identifiable, Hashable, Sendable {
    let id: Int
    let imageName: String
    let titleKey: String
    let captionKey: String
    let aspectRatio: CGFloat

    var thumbnailName: String { "thumb-" + imageName }
}
