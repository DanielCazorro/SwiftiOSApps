//
//  BundledQuoteRepository.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import Foundation

struct BundledQuoteRepository: QuoteRepository {
    func allQuotes() -> [Quote] {
        (1...6).map { index in
            Quote(id: "quote.\(index)", textKey: "quote.\(index).text", authorKey: "quote.\(index).author")
        }
    }
}
