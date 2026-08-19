//
//  WatchlistApp.swift
//  Watchlist
//
//  Created by Daniel Cazorro on 18/08/2026.
//

import SwiftUI
import SwiftData

@main
struct WatchlistApp: App {
    /// Built once, explicitly, so a failure to open the store surfaces here
    /// rather than silently somewhere deep in a view.
    private let modelContainer: ModelContainer

    init() {
        #if DEBUG
        // Launch with `-seedSampleData` (scheme arguments, or `simctl launch`) to
        // start from a populated in-memory list — handy for screenshots and demos.
        if ProcessInfo.processInfo.arguments.contains("-seedSampleData") {
            modelContainer = PreviewContainer.populated
            return
        }
        #endif

        do {
            modelContainer = try ModelContainer(for: Movie.self)
        } catch {
            // Failing here means the on-disk store cannot be opened at all;
            // there is no sensible way to keep going without it.
            fatalError("Could not open the Watchlist store: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            WatchlistView()
        }
        .modelContainer(modelContainer)
    }
}
