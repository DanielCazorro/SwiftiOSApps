//
//  Grocery_ListApp.swift
//  Grocery List
//
//  Created by Daniel Cazorro on 16/08/2026.
//

import SwiftUI
import SwiftData

@main
struct Grocery_ListApp: App {
    /// Built once at launch so a store failure surfaces here rather than
    /// crashing somewhere deep inside a view.
    private let modelContainer: ModelContainer

    init() {
        TipsConfiguration.configure()
        modelContainer = AppModelContainer.make()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }
}

// MARK: - Container

enum AppModelContainer {
    static let schema = Schema([Item.self])

    /// The on-disk container. A failure here means the store is unreadable and
    /// unrecoverable, so it is a genuine programmer/deployment error.
    static func make() -> ModelContainer {
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            let container = try ModelContainer(for: schema, configurations: configuration)
            // Free undo/redo for every edit made through the main context.
            container.mainContext.undoManager = UndoManager()
            #if DEBUG
            seedIfRequested(container)
            #endif
            return container
        } catch {
            fatalError("Could not create the SwiftData container: \(error)")
        }
    }

    #if DEBUG
    /// Launch with `-seedSampleData` (scheme argument) to start from a populated
    /// list — handy for screenshots and manual testing. Debug builds only.
    private static func seedIfRequested(_ container: ModelContainer) {
        guard ProcessInfo.processInfo.arguments.contains("-seedSampleData") else { return }
        let context = ModelContext(container)
        let existing = (try? context.fetchCount(FetchDescriptor<Item>())) ?? 0
        guard existing == 0 else { return }
        let items = Item.sampleList()
        items.prefix(3).forEach { $0.toggleCompletion() }
        for item in items { context.insert(item) }
        try? context.save()
    }
    #endif

    /// In-memory container for previews, optionally pre-seeded with sample data.
    @MainActor
    static func preview(seeded: Bool = true) -> ModelContainer {
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: configuration)
        if seeded {
            for item in Item.sampleList() {
                container.mainContext.insert(item)
            }
            // Give previews a realistic mix of done and pending rows.
            let fetched = (try? container.mainContext.fetch(FetchDescriptor<Item>())) ?? []
            for item in fetched.prefix(3) { item.toggleCompletion() }
        }
        return container
    }
}
