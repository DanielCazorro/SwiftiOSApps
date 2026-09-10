//
//  PageRepository.swift
//  Pinch
//
//  Created by Daniel Cazorro on 10/09/2026.
//

protocol PageRepository: Sendable {
    func allPages() -> [Page]
}
