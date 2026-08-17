//
//  ImageDownsampler.swift
//  Paws
//
//  Created by Daniel Cazorro on 17/08/2026.
//

import UIKit

/// Photos coming from the library can be 10+ MB. Storing them as-is bloats the
/// SwiftData store and makes the grid stutter, so they are resized and
/// re-encoded before being saved.
enum ImageDownsampler {
    static let maxDimension: CGFloat = 1200
    static let compressionQuality: CGFloat = 0.8

    static func prepareForStorage(_ data: Data) -> Data {
        guard let image = UIImage(data: data) else { return data }

        let largestSide = max(image.size.width, image.size.height)
        guard largestSide > maxDimension else {
            return image.jpegData(compressionQuality: compressionQuality) ?? data
        }

        let scale = maxDimension / largestSide
        let targetSize = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = 1

        let resized = UIGraphicsImageRenderer(size: targetSize, format: format).image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }

        return resized.jpegData(compressionQuality: compressionQuality) ?? data
    }
}
