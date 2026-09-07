//
//  HomeView.swift
//  Restart
//
//  Created by Daniel Cazorro on 01/09/2026.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel: HomeViewModel

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    init(viewModel: HomeViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 20) {
            toolbar

            Spacer(minLength: 0)

            ZStack {
                CircleGroupView(color: .gray, opacity: 0.1)
                FloatingCharacterView(
                    imageName: "character-2",
                    accessibilityLabel: "home.character.image"
                )
                .padding()
            }

            Spacer(minLength: 0)

            quoteCard

            Spacer(minLength: 0)

            restartButton
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .readableContentWidth()
    }

    // MARK: - Toolbar

    private var toolbar: some View {
        HStack {
            Spacer()

            Button {
                viewModel.toggleSound()
            } label: {
                Image(systemName: viewModel.isSoundEnabled ? "speaker.wave.2.fill" : "speaker.slash.fill")
                    .imageScale(.large)
                    .frame(width: 44, height: 44)
                    .contentTransition(.symbolEffect(.replace))
            }
            .accessibilityLabel(viewModel.isSoundEnabled ? "home.sound.disable" : "home.sound.enable")
        }
    }

    // MARK: - Quote

    private var quoteCard: some View {
        VStack(spacing: 20) {
            VStack(spacing: 12) {
                Text(viewModel.currentQuote.text)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                Text(viewModel.currentQuote.author)
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.tertiary)
            }
            .id(viewModel.currentQuote.id)
            .transition(.opacity)
            .accessibilityElement(children: .combine)

            quoteActions
        }
        .padding(.horizontal)
        .animation(Motion.interactive(reduceMotion: reduceMotion), value: viewModel.currentQuote.id)
    }

    private var quoteActions: some View {
        HStack(spacing: 12) {
            if viewModel.canShowAnotherQuote {
                Button {
                    withAnimation(Motion.interactive(reduceMotion: reduceMotion)) {
                        viewModel.showAnotherQuote()
                    }
                } label: {
                    Label("home.quote.another", systemImage: "sparkles")
                }
            }

            ShareLink(item: viewModel.currentQuote.shareMessage) {
                Label("home.quote.share", systemImage: "square.and.arrow.up")
            }
            .accessibilityLabel("home.quote.share")
        }
        .font(.subheadline)
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .labelStyle(.titleAndIcon)
    }

    // MARK: - Restart

    private var restartButton: some View {
        Button {
            viewModel.restart()
        } label: {
            Label("home.restart", systemImage: "arrow.triangle.2.circlepath.circle.fill")
                .font(.system(.title3, design: .rounded).weight(.bold))
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .accessibilityHint("home.restart.hint")
    }
}

#Preview {
    let dependencies = AppDependencies.preview
    return HomeView(
        viewModel: HomeViewModel(
            quoteRepository: dependencies.quotes,
            feedback: dependencies.feedback,
            settings: dependencies.settings
        )
    )
}
