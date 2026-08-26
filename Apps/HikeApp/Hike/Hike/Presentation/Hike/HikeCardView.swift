//
//  HikeCardView.swift
//  Hike
//
//  Created by Daniel Cazorro on 20/08/2026.
//

import SwiftUI

struct HikeCardView: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @Bindable var viewModel: HikeCardViewModel

    private let photoDiameter: CGFloat = 256

    var body: some View {
        ZStack {
            CardBackgroundView()

            VStack(spacing: 20) {
                header
                photo

                if let hike = viewModel.currentHike {
                    trailFacts(for: hike)
                } else {
                    emptyState
                }

                exploreButton
            }
            .padding(.vertical, 28)
        }
        .sheet(isPresented: $viewModel.isShowingSettings) {
            SettingsView()
                .presentationDragIndicator(.visible)
                .presentationDetents([.medium, .large])
        }
        .sensoryFeedback(.impact(weight: .light), trigger: viewModel.exploreCount)
        .sensoryFeedback(.selection, trigger: viewModel.isCurrentHikeFavorite)
    }

    // MARK: - Header

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center) {
                Text("card.title")
                    .font(.system(size: 52, weight: .black))
                    .foregroundStyle(.hikeTitle)
                    .lineLimit(1)
                    .minimumScaleFactor(0.35)
                    .layoutPriority(1)

                Spacer(minLength: 8)

                favoriteButton
                settingsButton
            }

            Text("card.subtitle")
                .italic()
                .foregroundStyle(Color.customGrayMedium)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, 24)
    }

    private var favoriteButton: some View {
        Button {
            viewModel.toggleFavorite()
        } label: {
            HikeIconButtonLabel(
                systemImage: viewModel.isCurrentHikeFavorite ? "heart.fill" : "heart"
            )
        }
        .disabled(viewModel.currentHike == nil)
        .accessibilityLabel(
            viewModel.isCurrentHikeFavorite
                ? Text("card.favorite.remove")
                : Text("card.favorite.add")
        )
    }

    private var settingsButton: some View {
        Button {
            viewModel.showSettings()
        } label: {
            HikeIconButtonLabel(systemImage: "figure.hiking")
        }
        .accessibilityLabel(Text("card.settings.open"))
    }

    // MARK: - Photo

    private var photo: some View {
        ZStack {
            AnimatedCircleView(diameter: photoDiameter)

            if let hike = viewModel.currentHike {
                Image(hike.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: photoDiameter, height: photoDiameter)
                    .id(hike.id)
                    .transition(photoTransition)
                    .accessibilityLabel(Text("card.photo.accessibilityLabel \(hike.localizedName)"))
            }
        }
        .animation(.smooth(duration: 0.45), value: viewModel.currentIndex)
    }

    private var photoTransition: AnyTransition {
        guard !reduceMotion else { return .opacity }
        return .asymmetric(
            insertion: .scale(scale: 0.92).combined(with: .opacity),
            removal: .opacity
        )
    }

    // MARK: - Trail facts

    private func trailFacts(for hike: Hike) -> some View {
        VStack(spacing: 10) {
            Text(hike.name)
                .font(.title3.weight(.heavy))
                .foregroundStyle(Color.customGrayMedium)

            Label {
                Text(hike.location)
            } icon: {
                Image(systemName: "mappin.and.ellipse")
            }
            .font(.footnote)
            .foregroundStyle(Color.customGrayLight)

            HStack(spacing: 0) {
                fact(
                    titleKey: "card.fact.distance",
                    value: viewModel.formatDistance(hike.distance),
                    symbol: "arrow.left.and.right"
                )

                divider

                fact(
                    titleKey: "card.fact.elevation",
                    value: viewModel.formatElevationGain(hike.elevationGain),
                    symbol: "arrow.up.right"
                )

                divider

                fact(
                    titleKey: "card.fact.difficulty",
                    value: hike.difficulty.localizedName,
                    symbol: hike.difficulty.symbolName
                )
            }
            .padding(.top, 4)
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, 24)
        .animation(.smooth(duration: 0.45), value: viewModel.currentIndex)
    }

    private func fact(titleKey: LocalizedStringKey, value: String, symbol: String) -> some View {
        VStack(spacing: 4) {
            Image(systemName: symbol)
                .font(.footnote.weight(.bold))

            Text(value)
                .font(.subheadline.weight(.heavy))
                .lineLimit(1)
                .minimumScaleFactor(0.7)

            Text(titleKey)
                .font(.caption2)
                .foregroundStyle(Color.customGrayLight)
        }
        .frame(maxWidth: .infinity)
        .foregroundStyle(Color.customGrayMedium)
        .accessibilityElement(children: .combine)
    }

    private var divider: some View {
        Rectangle()
            .fill(Color.customGrayLight.opacity(0.3))
            .frame(width: 1, height: 34)
            .accessibilityHidden(true)
    }

    private var emptyState: some View {
        Text("card.empty")
            .font(.subheadline)
            .foregroundStyle(Color.customGrayMedium)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 24)
    }

    // MARK: - Footer

    private var exploreButton: some View {
        Button {
            viewModel.showAnotherHike()
        } label: {
            Text("card.exploreMore")
                .font(.title2.weight(.heavy))
                .foregroundStyle(.hikeAccent)
                .shadow(color: .black.opacity(0.25), radius: 0.25, x: 1, y: 2)
        }
        .buttonStyle(.gradient)
        .disabled(!viewModel.canExplore)
    }
}

#Preview {
    HikeCardView(viewModel: HikeCardViewModel())
        .frame(maxWidth: 340)
        .padding()
}

#Preview("Empty state") {
    struct EmptyHikeRepository: HikeRepository {
        func allHikes() -> [Hike] { [] }
    }

    return HikeCardView(viewModel: HikeCardViewModel(hikeRepository: EmptyHikeRepository()))
        .frame(maxWidth: 340)
        .padding()
}
