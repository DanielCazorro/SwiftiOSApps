//
//  Tips.swift
//  Grocery List
//
//  Created by Daniel Cazorro on 16/08/2026.
//

import SwiftUI
import TipKit

/// Shown on the "starter list" button while the list is still empty.
struct StarterListTip: Tip {
    var title: Text { Text("Quick start") }

    var message: Text? {
        Text("Drop a handful of everyday groceries into the list so you can try things out.")
    }

    var image: Image? { Image(systemName: "lightbulb.fill") }

    var options: [any TipOption] { [Tips.MaxDisplayCount(3)] }
}

/// Shown once the list is big enough that filtering starts to pay off.
struct FilterTip: Tip {
    /// Mirrors the current list size. A parameter rather than an event, so that
    /// bulk inserts (the starter list) count for as much as one-by-one adds.
    @Parameter static var itemCount: Int = 0

    var title: Text { Text("Narrow things down") }

    var message: Text? {
        Text("Filter by aisle, priority or completion state to focus on what's left.")
    }

    var image: Image? { Image(systemName: "line.3.horizontal.decrease.circle") }

    var rules: [Rule] {
        #Rule(Self.$itemCount) { $0 >= 6 }
    }

    var options: [any TipOption] { [Tips.MaxDisplayCount(2)] }
}

/// Shown after the first few items are ticked off.
struct StatisticsTip: Tip {
    static let itemCompleted = Event(id: "itemCompleted")

    var title: Text { Text("Track your progress") }

    var message: Text? {
        Text("Open Statistics to see your completion rate and which aisles are busiest.")
    }

    var image: Image? { Image(systemName: "chart.bar.fill") }

    var rules: [Rule] {
        #Rule(Self.itemCompleted) { $0.donations.count >= 3 }
    }

    var options: [any TipOption] { [Tips.MaxDisplayCount(2)] }
}

// MARK: - Configuration

enum TipsConfiguration {
    /// Called once at launch. In debug builds the datastore is wiped so tips
    /// reappear on every run; release builds keep the user's real tip history.
    static func configure() {
        do {
            #if DEBUG
            try Tips.resetDatastore()
            #endif
            try Tips.configure([
                .displayFrequency(.immediate),
                .datastoreLocation(.applicationDefault)
            ])
        } catch {
            assertionFailure("Failed to configure TipKit: \(error)")
        }
    }

    /// Backing action for the "show tips again" button in Settings.
    static func reset() {
        try? Tips.resetDatastore()
    }
}
