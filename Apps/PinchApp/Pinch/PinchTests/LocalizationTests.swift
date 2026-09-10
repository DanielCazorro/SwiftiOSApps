//
//  LocalizationTests.swift
//  PinchTests
//
//  Created by Daniel Cazorro on 10/09/2026.
//

import Foundation
import Testing
@testable import Pinch

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

    /// A translation that drops or reorders a placeholder crashes `String(format:)`
    /// at runtime, so the specifiers have to match one for one.
    @Test("Placeholders survive translation")
    func placeholdersMatch() throws {
        let english = try Self.strings(for: "en")
        let spanish = try Self.strings(for: "es")

        for (key, value) in english {
            let translated = try #require(spanish[key])
            #expect(Self.specifiers(in: value) == Self.specifiers(in: translated),
                    "\(key): \(value) vs \(translated)")
        }
    }

    @Test("Every page resolves its title and caption in both languages")
    func pageKeysAreTranslated() throws {
        for language in Self.languages {
            let table = try Self.strings(for: language)
            for page in BundledPageRepository().allPages() {
                #expect(table[page.titleKey] != nil, "\(language): missing \(page.titleKey)")
                #expect(table[page.captionKey] != nil, "\(language): missing \(page.captionKey)")
            }
        }
    }

    @Test("Formatted copy comes out with its values filled in")
    func formattedStringsAreResolved() {
        let position = ViewerStrings.pagePosition(2, of: 7)
        #expect(position.contains("2"))
        #expect(position.contains("7"))
        #expect(!position.contains("%"))

        let zoom = ViewerStrings.zoomPercentage(320)
        #expect(zoom.contains("320"))
        #expect(zoom.contains("%"))
        #expect(!zoom.contains("%lld"))
    }

    private static func specifiers(in value: String) -> [String] {
        let pattern = /%(\d+\$)?[@a-zA-Z]/
        return value.matches(of: pattern).map { String($0.output.0) }.sorted()
    }
}
