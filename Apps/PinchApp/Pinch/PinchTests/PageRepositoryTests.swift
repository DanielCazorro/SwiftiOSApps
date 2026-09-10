//
//  PageRepositoryTests.swift
//  PinchTests
//
//  Created by Daniel Cazorro on 10/09/2026.
//

import Testing
import UIKit
@testable import Pinch

@Suite("Pages")
struct PageRepositoryTests {
    private let pages = BundledPageRepository().allPages()

    @Test("The magazine ships with pages, numbered in reading order")
    func pagesAreNumberedInOrder() {
        #expect(!pages.isEmpty)
        #expect(pages.map(\.id) == Array(1...pages.count))
    }

    @Test("Every page has artwork and a thumbnail in the asset catalogue")
    func artworkExists() {
        for page in pages {
            #expect(UIImage(named: page.imageName) != nil, "Missing artwork: \(page.imageName)")
            #expect(UIImage(named: page.thumbnailName) != nil, "Missing thumbnail: \(page.thumbnailName)")
        }
    }

    @Test("Thumbnails follow the naming the asset catalogue uses")
    func thumbnailNaming() throws {
        let page = try #require(pages.first)

        #expect(page.thumbnailName == "thumb-" + page.imageName)
    }

    @Test("Aspect ratios are read from the artwork, so panning matches the page")
    func aspectRatiosComeFromTheArtwork() throws {
        for page in pages {
            let artwork = try #require(UIImage(named: page.imageName))
            #expect(abs(page.aspectRatio - artwork.size.width / artwork.size.height) < 0.001)
            #expect(page.aspectRatio > 0)
        }
    }
}
