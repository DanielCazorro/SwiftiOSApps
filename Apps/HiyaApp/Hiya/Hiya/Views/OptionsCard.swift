//
//  OptionsCard.swift
//  Hiya
//
//  Created by Daniel Cazorro on 04/08/2026.
//

import SwiftUI

/// Panel con todo lo que se puede ajustar antes de pedir el saludo.
struct OptionsCard: View {
    @Binding var style: AnswerStyle
    @Binding var language: ResponseLanguage
    @Binding var topic: String
    @Binding var creativity: Double

    var isEnabled: Bool
    var onSubmit: () -> Void

    @FocusState private var isTopicFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            styleSection
            Divider().opacity(0.4)
            languageSection
            topicSection
            creativitySection
        }
        .padding(20)
        .glassEffect(.regular, in: .rect(cornerRadius: 28))
        .disabled(!isEnabled)
    }

    // MARK: - Tono

    private var styleSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionTitle("Style")

            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(AnswerStyle.allCases) { option in
                        StyleChip(style: option, isSelected: option == style) {
                            withAnimation(.snappy) { style = option }
                        }
                    }
                }
                .padding(.horizontal, 2)
                .padding(.vertical, 2)
            }
            .scrollIndicators(.hidden)
        }
    }

    // MARK: - Idioma

    private var languageSection: some View {
        HStack {
            sectionTitle("Language")
            Spacer()
            Picker("Language", selection: $language) {
                ForEach(ResponseLanguage.allCases) { option in
                    Text("\(option.flag)  \(option.displayName)").tag(option)
                }
            }
            .pickerStyle(.menu)
            .labelsHidden()
        }
    }

    // MARK: - Tema libre

    private var topicSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            sectionTitle("About (optional)")

            HStack(spacing: 8) {
                Image(systemName: "text.bubble")
                    .foregroundStyle(.secondary)

                TextField("Monday, coffee, the beach…", text: $topic, axis: .vertical)
                    .lineLimit(1...3)
                    .focused($isTopicFocused)
                    .submitLabel(.go)
                    .onSubmit(onSubmit)

                if !topic.isEmpty {
                    Button {
                        topic = ""
                        isTopicFocused = true
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Clear text")
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 11)
            .background(.thinMaterial, in: .rect(cornerRadius: 14))
        }
    }

    // MARK: - Creatividad

    private var creativitySection: some View {
        VStack(alignment: .leading, spacing: 4) {
            sectionTitle("Creativity")

            Slider(value: $creativity, in: 0...2, step: 0.1) {
                Text("Creativity")
            } minimumValueLabel: {
                Image(systemName: "target").font(.caption)
            } maximumValueLabel: {
                Image(systemName: "sparkles").font(.caption)
            }
        }
    }

    private func sectionTitle(_ key: LocalizedStringKey) -> some View {
        Text(key)
            .font(.caption.weight(.semibold))
            .textCase(.uppercase)
            .foregroundStyle(.secondary)
    }
}

/// Píldora seleccionable para cada tono.
private struct StyleChip: View {
    let style: AnswerStyle
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Label {
                Text(style.title)
            } icon: {
                Image(systemName: style.symbol)
            }
            .font(.subheadline.weight(.medium))
            .padding(.horizontal, 14)
            .padding(.vertical, 9)
        }
        .buttonStyle(.plain)
        .background {
            Capsule()
                .fill(isSelected ? AnyShapeStyle(.tint) : AnyShapeStyle(.thinMaterial))
        }
        .foregroundStyle(isSelected ? .white : .primary)
        .accessibilityAddTraits(isSelected ? [.isSelected] : [])
    }
}

// MARK: - Previews

/// Envoltorio para no repetir los cuatro `@State` en cada preview.
#if DEBUG
private struct OptionsCardPreview: View {
    var topic: String = ""
    var style: AnswerStyle = .fun
    var isEnabled: Bool = true

    @State private var currentStyle: AnswerStyle = .fun
    @State private var language: ResponseLanguage = .spanish
    @State private var currentTopic = ""
    @State private var creativity = 1.0

    var body: some View {
        OptionsCard(
            style: $currentStyle,
            language: $language,
            topic: $currentTopic,
            creativity: $creativity,
            isEnabled: isEnabled,
            onSubmit: {}
        )
        .padding()
        .tint(.purple)
        .onAppear {
            currentStyle = style
            currentTopic = topic
        }
    }
}
#endif

#Preview("Por defecto", traits: .sizeThatFitsLayout) {
    OptionsCardPreview()
}

#Preview("Con tema escrito", traits: .sizeThatFitsLayout) {
    OptionsCardPreview(topic: "el café de la mañana", style: .pirate)
}

/// Mientras la IA escribe el panel se deshabilita: conviene ver que se nota.
#Preview("Deshabilitado", traits: .sizeThatFitsLayout) {
    OptionsCardPreview(isEnabled: false)
}

/// En inglés las etiquetas son más largas y es donde antes se corta el texto.
#Preview("Inglés", traits: .sizeThatFitsLayout) {
    OptionsCardPreview()
        .environment(\.locale, Locale(identifier: "en"))
}

#Preview("Texto grande", traits: .sizeThatFitsLayout) {
    OptionsCardPreview()
        .environment(\.dynamicTypeSize, .accessibility1)
}

#Preview("Oscuro") {
    ZStack {
        AuroraBackground()
        OptionsCardPreview()
    }
    .preferredColorScheme(.dark)
}
