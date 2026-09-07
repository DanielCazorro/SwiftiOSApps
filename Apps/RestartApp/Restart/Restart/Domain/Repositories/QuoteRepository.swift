//
//  QuoteRepository.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import Foundation

protocol QuoteRepository: Sendable {
    func allQuotes() -> [Quote]
}
