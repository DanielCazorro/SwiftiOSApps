//
//  LocalizationTests.swift
//  HikeTests
//
//  Created by Daniel Cazorro on 26/08/2026.
//

import Foundation
import Testing
@testable import Hike

@Suite("Localization")
struct LocalizationTests {
    private static let languages = ["en", "es"]

    private static func strings(for language: String) throws -> [String: String] {
        let bundle = Bundle.main
        let url = try #require(
            bundle.url(forResource: "Localizable", withExtension: "strings", subdirectory: "\(language).lproj"),
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

    @Test("Every trail resolves a name and a location in both languages")
    func trailKeysAreTranslated() throws {
        for language in Self.languages {
            let table = try Self.strings(for: language)
            for hike in BundledHikeRepository().allHikes() {
                #expect(table[hike.nameKey] != nil, "\(language): missing \(hike.nameKey)")
                #expect(table[hike.locationKey] != nil, "\(language): missing \(hike.locationKey)")
            }
        }
    }

    @Test("Every enum-backed key is translated in both languages")
    func enumKeysAreTranslated() throws {
        let keys = HikeDifficulty.allCases.map(\.localizationKey)
            + AppIcon.allCases.map(\.localizationKey)

        for language in Self.languages {
            let table = try Self.strings(for: language)
            for key in keys {
                #expect(table[key] != nil, "\(language): missing \(key)")
            }
        }
    }

    @Test("Lookups return real copy, never the key itself")
    func lookupsResolve() {
        for hike in BundledHikeRepository().allHikes() {
            #expect(hike.localizedName != hike.nameKey)
        }
        for difficulty in HikeDifficulty.allCases {
            #expect(difficulty.localizedName != difficulty.localizationKey)
        }
    }

    @Test("Format specifiers match across languages")
    func formatSpecifiersMatch() throws {
        let english = try Self.strings(for: "en")
        let spanish = try Self.strings(for: "es")

        for (key, englishValue) in english {
            guard let spanishValue = spanish[key] else { continue }
            #expect(
                Self.placeholderCount(in: englishValue) == Self.placeholderCount(in: spanishValue),
                "Placeholder mismatch for \(key)"
            )
        }
    }

    private static func placeholderCount(in value: String) -> Int {
        let pattern = /%(?:\d+\$)?[@dfs]/
        return value.matches(of: pattern).count
    }
}
