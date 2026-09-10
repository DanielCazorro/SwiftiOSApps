//
//  PageDrawerView.swift
//  Pinch
//
//  Created by Daniel Cazorro on 10/09/2026.
//

import SwiftUI

struct PageDrawerView: View {
    let pages: [Page]
    let selectedPageID: Page.ID
    let isOpen: Bool
    let onToggle: () -> Void
    let onSelect: (Page.ID) -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        HStack(spacing: isOpen ? 10 : 0) {
            Button(action: onToggle) {
                Image(systemName: isOpen ? "chevron.compact.right" : "chevron.compact.left")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundStyle(.secondary)
                    .frame(width: Layout.drawerHandleWidth, height: 56)
                    .contentShape(.rect)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(isOpen ? "viewer.pages.hide" : "viewer.pages.show")

            if isOpen {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(pages) { page in
                            thumbnail(for: page)
                        }
                    }
                    .padding(.horizontal, 2)
                }
                .frame(width: thumbnailStripWidth)
                .transition(.opacity)
            }
        }
        .padding(.vertical, 10)
        .padding(.trailing, isOpen ? 10 : 0)
        .background(.ultraThinMaterial, in: .rect(cornerRadius: Layout.panelCornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: Layout.panelCornerRadius)
                .strokeBorder(.primary.opacity(0.08))
        )
        .shadow(color: .black.opacity(0.15), radius: 12, y: 4)
        .padding(.trailing, isOpen ? 12 : -Layout.panelCornerRadius)
        .animation(Motion.drawer(reduceMotion: reduceMotion), value: isOpen)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("viewer.pages.drawer")
    }

    private var thumbnailStripWidth: CGFloat {
        let count = CGFloat(pages.count)
        let ideal = count * Layout.thumbnailWidth + max(0, count - 1) * 10 + 4
        return min(ideal, Layout.drawerWidth - Layout.drawerHandleWidth)
    }

    private func thumbnail(for page: Page) -> some View {
        let isSelected = page.id == selectedPageID
        return Button {
            onSelect(page.id)
        } label: {
            page.thumbnail
                .resizable()
                .scaledToFit()
                .frame(width: Layout.thumbnailWidth)
                .clipShape(.rect(cornerRadius: Layout.thumbnailCornerRadius))
                .overlay(
                    RoundedRectangle(cornerRadius: Layout.thumbnailCornerRadius)
                        .strokeBorder(isSelected ? Color.accentColor : .clear, lineWidth: 3)
                )
                .shadow(radius: 3)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(page.title)
        .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : .isButton)
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.3).ignoresSafeArea()
        PageDrawerView(
            pages: BundledPageRepository().allPages(),
            selectedPageID: 1,
            isOpen: true,
            onToggle: {},
            onSelect: { _ in }
        )
    }
    .preferredColorScheme(.dark)
}
