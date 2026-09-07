//
//  OnboardingView.swift
//  Restart
//
//  Created by Daniel Cazorro on 01/09/2026.
//

import SwiftUI

struct OnboardingView: View {
    @State private var viewModel: OnboardingViewModel

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var hasAppeared = false

    init(viewModel: OnboardingViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        ZStack {
            LinearGradient.brandBackground
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer(minLength: 0)
                header
                Spacer(minLength: 0)
                character
                Spacer(minLength: 0)
                footer
            }
            .padding(.horizontal, Layout.horizontalPadding)
            .padding(.vertical, 24)
            .readableContentWidth()
        }
        .onAppear { hasAppeared = true }
        .tint(.white)
    }

    // MARK: - Header

    private var header: some View {
        VStack(spacing: 12) {
            Text(viewModel.currentSlide.title)
                .font(.system(size: 60, weight: .heavy))
                .minimumScaleFactor(0.5)
                .lineLimit(1)

            Text(viewModel.currentSlide.message)
                .font(.title3)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
        }
        .foregroundStyle(.white)
        .id(viewModel.currentIndex)
        .transition(.opacity)
        .opacity(hasAppeared ? 1 : 0)
        .offset(y: hasAppeared ? 0 : -40)
        .animation(Motion.entrance(reduceMotion: reduceMotion), value: hasAppeared)
        .animation(Motion.interactive(reduceMotion: reduceMotion), value: viewModel.currentIndex)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isHeader)
    }

    // MARK: - Character

    private var character: some View {
        ZStack {
            CircleGroupView(color: .white, opacity: 0.2)
                .offset(x: -viewModel.characterOffset)
                .blur(radius: abs(viewModel.characterOffset) / 5)

            FloatingCharacterView(
                imageName: viewModel.currentSlide.imageName,
                accessibilityLabel: viewModel.currentSlide.imageAccessibilityLabel,
                amplitude: 12
            )
            .id(viewModel.currentSlide.id)
            .transition(.opacity)
            .opacity(hasAppeared ? 1 : 0)
            .offset(x: viewModel.characterOffset)
            .rotationEffect(.degrees(viewModel.characterOffset / 20))
            .gesture(characterDrag)
            .accessibilityAddTraits(.isImage)
            .accessibilityHint("onboarding.character.hint")
            .accessibilityAction(named: "onboarding.action.next") {
                withAnimation(Motion.interactive(reduceMotion: reduceMotion)) {
                    viewModel.move(to: viewModel.currentIndex + 1)
                }
            }
            .accessibilityAction(named: "onboarding.action.previous") {
                withAnimation(Motion.interactive(reduceMotion: reduceMotion)) {
                    viewModel.move(to: viewModel.currentIndex - 1)
                }
            }
        }
        .animation(Motion.interactive(reduceMotion: reduceMotion), value: viewModel.characterOffset)
        .animation(Motion.entrance(reduceMotion: reduceMotion), value: hasAppeared)
        .overlay(alignment: .bottom) {
            Image(systemName: "arrow.left.and.right.circle")
                .font(.system(size: 44, weight: .ultraLight))
                .foregroundStyle(.white)
                .offset(y: 20)
                .opacity(hasAppeared && viewModel.isDragHintVisible ? 1 : 0)
                .animation(Motion.entrance(reduceMotion: reduceMotion, delay: 1.5), value: hasAppeared)
                .animation(Motion.interactive(reduceMotion: reduceMotion), value: viewModel.isDragHintVisible)
                .accessibilityHidden(true)
        }
    }

    private var characterDrag: some Gesture {
        DragGesture()
            .onChanged { gesture in
                viewModel.dragCharacter(by: gesture.translation.width)
            }
            .onEnded { _ in
                withAnimation(Motion.interactive(reduceMotion: reduceMotion)) {
                    viewModel.endCharacterDrag()
                }
            }
    }

    // MARK: - Footer

    private var footer: some View {
        VStack(spacing: 24) {
            PageIndicatorView(count: viewModel.slides.count, currentIndex: viewModel.currentIndex) { index in
                withAnimation(Motion.interactive(reduceMotion: reduceMotion)) {
                    viewModel.move(to: index)
                }
            }

            if viewModel.isLastSlide {
                SlideToStartControl(
                    offset: viewModel.sliderOffset,
                    onDragChanged: { translation, width in
                        viewModel.dragSlider(by: translation, trackWidth: width)
                    },
                    onDragEnded: { width in
                        viewModel.endSliderDrag(trackWidth: width)
                    },
                    onActivate: viewModel.complete
                )
                .transition(.opacity.combined(with: .move(edge: .bottom)))
            } else {
                Button("onboarding.cta.skip") {
                    withAnimation(Motion.interactive(reduceMotion: reduceMotion)) {
                        viewModel.move(to: viewModel.slides.count - 1)
                    }
                }
                .font(.system(.title3, design: .rounded).weight(.semibold))
                .foregroundStyle(.white.opacity(0.85))
                .frame(height: Layout.controlHeight)
                .transition(.opacity)
            }
        }
        .opacity(hasAppeared ? 1 : 0)
        .offset(y: hasAppeared ? 0 : 40)
        .animation(Motion.entrance(reduceMotion: reduceMotion), value: hasAppeared)
        .animation(Motion.interactive(reduceMotion: reduceMotion), value: viewModel.isLastSlide)
    }
}

#Preview {
    let dependencies = AppDependencies.preview
    return OnboardingView(
        viewModel: OnboardingViewModel(
            content: dependencies.onboardingContent,
            feedback: dependencies.feedback,
            settings: dependencies.settings
        )
    )
}
