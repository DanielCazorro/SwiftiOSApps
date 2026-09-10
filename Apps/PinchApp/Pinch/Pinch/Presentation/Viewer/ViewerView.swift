//
//  ViewerView.swift
//  Pinch
//
//  Created by Daniel Cazorro on 08/09/2026.
//

import SwiftUI

struct ViewerView: View {
    @State private var model: ViewerViewModel
    private let settings: AppSettings

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    init(dependencies: AppDependencies) {
        self.settings = dependencies.settings
        _model = State(
            initialValue: ViewerViewModel(
                pageRepository: dependencies.pages,
                haptics: dependencies.haptics,
                settings: dependencies.settings
            )
        )
    }

    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                stage(in: proxy.size)
                    .onAppear { model.viewportChanged(to: proxy.size) }
                    .onChange(of: proxy.size) { _, newSize in
                        model.viewportChanged(to: newSize)
                    }
            }
            .padding(Layout.pagePadding)
            .background(background)
            .overlay(alignment: .top) { zoomBadge }
            .overlay(alignment: .bottom) { bottomBar }
            .overlay(alignment: .topTrailing) { drawer }
            .navigationTitle(model.currentPage.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { toolbarContent }
            .sheet(isPresented: $model.isGuidePresented, onDismiss: model.guideDismissed) {
                GuideView(settings: settings)
            }
            .onAppear { model.onAppear() }
        }
    }

    // MARK: - Page

    private func stage(in size: CGSize) -> some View {
        ZStack {
            Color.clear
            pageImage
        }
        .contentShape(.rect)
        .gesture(doubleTap(in: size))
        .simultaneousGesture(dragGesture)
        .simultaneousGesture(magnifyGesture(in: size))
    }

    private var pageImage: some View {
        model.currentPage.image
            .resizable()
            .scaledToFit()
            .clipShape(.rect(cornerRadius: Layout.pageCornerRadius))
            .shadow(color: .black.opacity(0.25), radius: 14, y: 6)
            .scaleEffect(model.zoom.scale)
            .offset(
                x: model.zoom.offset.width + model.pageTurnTranslation,
                y: model.zoom.offset.height
            )
            .id(model.currentPageID)
            .transition(.opacity)
            .animation(Motion.pageChange(reduceMotion: reduceMotion), value: model.currentPageID)
            .accessibilityElement()
            .accessibilityLabel(model.currentPage.caption)
            .accessibilityValue(Text(ViewerStrings.zoomPercentage(model.zoom.percentage)))
            .accessibilityHint("viewer.image.hint")
            .accessibilityAdjustableAction { direction in
                switch direction {
                case .increment: model.zoomIn()
                case .decrement: model.zoomOut()
                @unknown default: break
                }
            }
            .accessibilityAction(named: Text("viewer.page.next")) { model.showNextPage() }
            .accessibilityAction(named: Text("viewer.page.previous")) { model.showPreviousPage() }
    }

    private var background: some View {
        LinearGradient(
            colors: [Color(.systemBackground), Color(.secondarySystemBackground)],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }

    // MARK: - Gestures

    private func doubleTap(in size: CGSize) -> some Gesture {
        SpatialTapGesture(count: 2)
            .onEnded { value in
                withAnimation(Motion.zoom(reduceMotion: reduceMotion)) {
                    model.handleDoubleTap(at: value.location)
                }
            }
    }

    /// No animation while the finger is down: the page should track the gesture,
    /// not lag a second behind it the way an animated assignment would.
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 2)
            .onChanged { value in
                model.dragChanged(translation: value.translation)
            }
            .onEnded { value in
                withAnimation(Motion.zoom(reduceMotion: reduceMotion)) {
                    model.dragEnded(translation: value.translation)
                }
            }
    }

    private func magnifyGesture(in size: CGSize) -> some Gesture {
        MagnifyGesture(minimumScaleDelta: 0.01)
            .onChanged { value in
                model.magnificationChanged(
                    to: value.magnification,
                    anchor: CGPoint(
                        x: value.startAnchor.x * size.width,
                        y: value.startAnchor.y * size.height
                    )
                )
            }
            .onEnded { _ in
                withAnimation(Motion.zoom(reduceMotion: reduceMotion)) {
                    model.magnificationEnded()
                }
            }
    }

    // MARK: - Chrome

    @ViewBuilder
    private var zoomBadge: some View {
        if model.zoom.isZoomedIn {
            ZoomBadgeView(percentage: model.zoom.percentage)
                .padding(.top, 8)
                .transition(.move(edge: .top).combined(with: .opacity))
        }
    }

    private var bottomBar: some View {
        VStack(spacing: 10) {
            Text(ViewerStrings.pagePosition(model.currentIndex + 1, of: model.pages.count))
                .font(.caption.weight(.medium))
                .monospacedDigit()
                .foregroundStyle(.secondary)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(.ultraThinMaterial, in: .capsule)
                .accessibilityHidden(true)

            ZoomControlsView(
                canZoomOut: model.zoom.canZoomOut,
                canZoomIn: model.zoom.canZoomIn,
                isZoomedIn: model.zoom.isZoomedIn,
                zoomPercentage: model.zoom.percentage,
                onZoomOut: { withAnimation(Motion.zoom(reduceMotion: reduceMotion)) { model.zoomOut() } },
                onReset: { withAnimation(Motion.zoom(reduceMotion: reduceMotion)) { model.resetZoom() } },
                onZoomIn: { withAnimation(Motion.zoom(reduceMotion: reduceMotion)) { model.zoomIn() } }
            )
        }
        .padding(.bottom, 12)
    }

    private var drawer: some View {
        PageDrawerView(
            pages: model.pages,
            selectedPageID: model.currentPageID,
            isOpen: model.isDrawerOpen,
            onToggle: { model.toggleDrawer() },
            onSelect: { pageID in
                withAnimation(Motion.zoom(reduceMotion: reduceMotion)) {
                    model.select(pageID: pageID)
                }
            }
        )
        .padding(.top, 16)
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: model.showGuide) {
                Image(systemName: "questionmark.circle")
            }
            .accessibilityLabel("viewer.guide")
        }

        ToolbarItem(placement: .topBarTrailing) {
            ShareLink(
                item: model.currentPage.image,
                preview: SharePreview(model.currentPage.title, image: model.currentPage.image)
            ) {
                Image(systemName: "square.and.arrow.up")
            }
            .accessibilityLabel("viewer.share")
        }

        ToolbarItem(placement: .topBarTrailing) {
            Button {
                model.toggleDrawer()
            } label: {
                Image(systemName: model.isDrawerOpen ? "rectangle.righthalf.inset.filled" : "photo.stack")
            }
            .accessibilityLabel(model.isDrawerOpen ? "viewer.pages.hide" : "viewer.pages.show")
        }
    }
}

#Preview {
    ViewerView(dependencies: .preview)
        .preferredColorScheme(.dark)
}
