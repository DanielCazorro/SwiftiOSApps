# Grocery List

A small SwiftUI shopping-list app, built as a playground for **TipKit**, **SwiftData** and **Swift Charts**.
Fully localised in English (source) and Spanish.

## Requirements

- Xcode 26 · iOS 26.5 deployment target
- No external dependencies

## Structure

```
Grocery List/
├── Grocery_ListApp.swift     @main + ModelContainer setup (app / preview / debug seed)
├── Models/                   Item (@Model) and its value types
│   ├── Item.swift
│   ├── GroceryCategory.swift  aisle, symbol, tint, aisle order
│   ├── Priority.swift
│   ├── GroceryUnit.swift      units, packs, g/kg, ml/L
│   └── GroceryStatistics.swift  derived from items, never stored
├── Store/
│   └── GroceryListViewModel.swift  search, filters, sorting, grouping, plain-text export
├── Views/
│   ├── ContentView.swift      list, sections, swipe actions, toolbar
│   ├── ItemRowView.swift
│   ├── ItemDetailView.swift
│   ├── AddEditItemView.swift  edits a Draft, writes back only on save
│   ├── FilterView.swift
│   ├── StatisticsView.swift   completion ring + stacked bar chart
│   └── SettingsView.swift
├── Support/
│   ├── Tips.swift             tip definitions + TipKit configuration
│   ├── Haptics.swift
│   └── PreviewSupport.swift
├── Localizable.xcstrings      String Catalog — en (source) + es, plurals included
└── InfoPlist.xcstrings        localised app name
```

The target uses an Xcode **synchronized folder group**, so new files added to these
folders are picked up automatically — no `.pbxproj` editing needed.

## Notes

**State.** SwiftData owns the items (`@Query`); `GroceryListViewModel` owns everything
that is *not* persisted with the data — search text, active filters, sort order,
grouping. Display preferences survive relaunches via `UserDefaults`.

Filtering runs in memory rather than through a `#Predicate` because search also
matches *localised* aisle names, which SwiftData cannot express in a predicate.

**Localisation.** Source strings are plain English literals in the code; Xcode
extracts them into `Localizable.xcstrings`. Enum display names use
`LocalizedStringResource`, and count-bearing strings use proper plural variations
(`one` / `other`) in both languages. Starter-list item names are resolved at
creation time, since they become ordinary user data once inserted.

**TipKit** is configured once in `Grocery_ListApp.init()`. Debug builds reset the
datastore each launch so tips always show; release builds keep the real history.
Two tips are gated on donated events (list grew, items completed) instead of firing
immediately.

## Running with sample data

Debug builds accept a launch argument that seeds a populated list:

```
xcrun simctl launch booted com.DanielCazorro.Grocery-List -seedSampleData
```

Or add `-seedSampleData` under *Product → Scheme → Edit Scheme → Arguments*.

## Not done yet

There is no test target. Adding one (*File → New → Target → Unit Testing Bundle*)
would be worthwhile: `GroceryListViewModel` and `GroceryStatistics` are plain,
dependency-free types and are straightforward to cover with Swift Testing.
