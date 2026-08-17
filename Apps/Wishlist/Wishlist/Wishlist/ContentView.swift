//
//  ContentView.swift
//  Wishlist
//
//  Created by Daniel Cazorro on 15/08/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Wish.createdAt, order: .reverse) private var wishes: [Wish]
    
    @State private var isAddingWish = false
    @State private var newWishTitle = ""
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                wishList

                if !wishes.isEmpty {
                    wishCounter
                }
            }
            .navigationTitle("Wishlist")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    addButton
                }
            }
            .alert("Create a New Wish", isPresented: $isAddingWish) {
                TextField("Enter your wish", text: $newWishTitle)
                    .autocorrectionDisabled()

                Button("Save", action: saveWish)
                Button("Cancel", role: .cancel) {
                    newWishTitle = ""
                }
            } message: {
                Text("What would you like to wish for?")
            }
            .overlay {
                if wishes.isEmpty {
                    emptyState
                }
            }
        }
    }
    
    // MARK: - Subviews
    
    private var wishList: some View {
        List {
            ForEach(wishes) { wish in
                WishRowView(wish: wish)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Delete", role: .destructive) {
                            deleteWish(wish)
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            toggleCompletion(for: wish)
                        } label: {
                            Label(
                                wish.isCompleted ? "Undo" : "Complete",
                                systemImage: wish.isCompleted ? "arrow.uturn.backward" : "checkmark"
                            )
                        }
                        .tint(wish.isCompleted ? .orange : .green)
                    }
            }
        }
        .listStyle(.plain)
    }
    
    private var addButton: some View {
        Button {
            isAddingWish = true
        } label: {
            Image(systemName: "plus.circle.fill")
                .imageScale(.large)
                .symbolRenderingMode(.hierarchical)
        }
    }
    
    private var wishCounter: some View {
        VStack(spacing: 0) {
            Spacer()
            
            HStack(spacing: 4) {
                Image(systemName: "heart.fill")
                    .imageScale(.small)
                    .foregroundStyle(.pink)
                
                Text(counterText)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
        }
        .ignoresSafeArea(edges: .bottom)
    }
    
    private var emptyState: some View {
        ContentUnavailableView {
            Label("My Wishlist", systemImage: "heart.circle")
        } description: {
            Text("No wishes yet. Tap the + button to add your first wish.")
        }
    }
    
    // MARK: - Computed Properties
    
    private var counterText: String {
        let count = wishes.count
        let completedCount = wishes.filter(\.isCompleted).count
        
        if completedCount > 0 {
            return "\(count) wish\(count != 1 ? "es" : "") (\(completedCount) completed)"
        } else {
            return "\(count) wish\(count != 1 ? "es" : "")"
        }
    }
    
    // MARK: - Actions
    
    private func saveWish() {
        let trimmedTitle = newWishTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return }
        
        withAnimation {
            let wish = Wish(title: trimmedTitle)
            modelContext.insert(wish)
            newWishTitle = ""
        }
    }
    
    private func deleteWish(_ wish: Wish) {
        withAnimation {
            modelContext.delete(wish)
        }
    }
    
    private func toggleCompletion(for wish: Wish) {
        withAnimation {
            wish.isCompleted.toggle()
        }
    }
}

// MARK: - Wish Row View

struct WishRowView: View {
    let wish: Wish
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(wish.title)
                .font(.title3.weight(.medium))
                .strikethrough(wish.isCompleted, color: .secondary)
                .foregroundStyle(wish.isCompleted ? .secondary : .primary)
            
            Text(wish.createdAt, style: .relative)
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Previews

#Preview("List with Sample Data") {
    let container = try! ModelContainer(
        for: Wish.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    
    let sampleWishes = [
        Wish(title: "Master SwiftData", createdAt: .now.addingTimeInterval(-86400 * 5)),
        Wish(title: "Buy a new iPhone", createdAt: .now.addingTimeInterval(-86400 * 3), isCompleted: true),
        Wish(title: "Practice Swift exercises", createdAt: .now.addingTimeInterval(-86400 * 2)),
        Wish(title: "Travel to Europe", createdAt: .now.addingTimeInterval(-86400)),
        Wish(title: "Make a positive impact", createdAt: .now)
    ]
    
    sampleWishes.forEach { container.mainContext.insert($0) }
    
    return ContentView()
        .modelContainer(container)
}

#Preview("Empty List") {
    ContentView()
        .modelContainer(for: Wish.self, inMemory: true)
}
