//
//  LocalizationTests.swift
//  RestartTests
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import Foundation
import Testing
@testable import Restart

@Suite("Localization")
struct LocalizationTests {
    private static let languages = ["en", "es"]

    private static func strings(for language: String) throws -> [String: String] {
        let url = try #require(
            Bundle.main.url(forResource: "Localizable", withExtension: "strings", subdirectory: "\(language).lproj"),
            "No compiled strings for \(language)"
        )
        let data = try Data(contentsOf: url)
        let plist = try PropertyListSerialization.propertyList(from: data, format: nil)
        return try #require(plist as? [String: String])
    }

    @Test("English and Spanish define exactly the same keys")
    func languagesAreInSync() throws {
        let english = try Self.strings(for: "en")
        let spanish = try Self.strings(for: "es")

        let missingInSpanish = Set(english.keys).subtracting(spanish.keys).sorted()
        let missingInEnglish = Set(spanish.keys).subtracting(english.keys).sorted()

        #expect(missingInSpanish.isEmpty, "Not translated to Spanish: \(missingInSpanish)")
        #expect(missingInEnglish.isEmpty, "Missing from English: \(missingInEnglish)")
    }

    @Test("No translation is left empty")
    func noEmptyTranslations() throws {
        for language in Self.languages {
            for (key, value) in try Self.strings(for: language) {
                #expect(!value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                        "\(language): \(key) is empty")
            }
        }
    }

    @Test("Every onboarding slide resolves its copy in both languages")
    func onboardingKeysAreTranslated() throws {
        for language in Self.languages {
            let table = try Self.strings(for: language)
            for slide in BundledOnboardingContentRepository().allSlides() {
                #expect(table[slide.titleKey] != nil, "\(language): missing \(slide.titleKey)")
                #expect(table[slide.messageKey] != nil, "\(language): missing \(slide.messageKey)")
                #expect(table[slide.imageAccessibilityKey] != nil, "\(language): missing \(slide.imageAccessibilityKey)")
            }
        }
    }

    @Test("Every quote resolves its text and author in both languages")
    func quoteKeysAreTranslated() throws {
        for language in Self.languages {
            let table = try Self.strings(for: language)
            for quote in BundledQuoteRepository().allQuotes() {
                #expect(table[quote.textKey] != nil, "\(language): missing \(quote.textKey)")
                #expect(table[quote.authorKey] != nil, "\(language): missing \(quote.authorKey)")
            }
        }
    }
}
