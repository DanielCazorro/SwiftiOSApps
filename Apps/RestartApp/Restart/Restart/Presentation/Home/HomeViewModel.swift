//
//  HomeViewModel.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class HomeViewModel {
    private let quotes: [Quote]
    private let feedback: FeedbackPlaying
    private let settings: AppSettings

    private(set) var currentQuote: Quote

    init(quoteRepository: QuoteRepository, feedback: FeedbackPlaying, settings: AppSettings) {
        let quotes = quoteRepository.allQuotes()
        assert(!quotes.isEmpty, "The home screen needs at least one quote")
        self.quotes = quotes
        self.feedback = feedback
        self.settings = settings
        self.currentQuote = quotes.randomElement() ?? quotes[0]
    }

    var isSoundEnabled: Bool {
        get { settings.isSoundEnabled }
        set { settings.isSoundEnabled = newValue }
    }

    var canShowAnotherQuote: Bool { quotes.count > 1 }

    func showAnotherQuote() {
        guard canShowAnotherQuote else { return }
        let candidates = quotes.filter { $0.id != currentQuote.id }
        guard let next = candidates.randomElement() else { return }
        currentQuote = next
        feedback.vibrate(.selection)
    }

    func toggleSound() {
        isSoundEnabled.toggle()
        feedback.vibrate(.selection)
        feedback.play(.restart)
    }

    func restart() {
        feedback.play(.restart)
        feedback.vibrate(.success)
        settings.hasCompletedOnboarding = false
    }
}
