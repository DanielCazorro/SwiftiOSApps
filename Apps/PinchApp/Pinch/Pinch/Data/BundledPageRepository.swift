//
//  BundledPageRepository.swift
//  Pinch
//
//  Created by Daniel Cazorro on 10/09/2026.
//

import UIKit

struct BundledPageRepository: PageRepository {
    private static let fallbackAspectRatio: CGFloat = 595.0 / 842.0

    private struct Descriptor: Sendable {
        let imageName: String
        let titleKey: String
        let captionKey: String
    }

    private static let descriptors: [Descriptor] = [
        Descriptor(
            imageName: "magazine-front-cover",
            titleKey: "page.front.title",
            captionKey: "page.front.caption"
        ),
        Descriptor(
            imageName: "magazine-back-cover",
            titleKey: "page.back.title",
            captionKey: "page.back.caption"
        )
    ]

    private let bundle: Bundle

    init(bundle: Bundle = .main) {
        self.bundle = bundle
    }

    func allPages() -> [Page] {
        Self.descriptors.enumerated().map { index, descriptor in
            Page(
                id: index + 1,
                imageName: descriptor.imageName,
                titleKey: descriptor.titleKey,
                captionKey: descriptor.captionKey,
                aspectRatio: aspectRatio(of: descriptor.imageName)
            )
        }
    }

    private func aspectRatio(of imageName: String) -> CGFloat {
        guard let size = UIImage(named: imageName, in: bundle, with: nil)?.size,
              size.width > 0, size.height > 0 else {
            return Self.fallbackAspectRatio
        }
        return size.width / size.height
    }
}
