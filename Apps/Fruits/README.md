# Fruits

A small SwiftUI app to browse fruits, their nutritional values and a bit of their history. It starts with an onboarding carousel and lets you replay it from Settings.

| Onboarding | Fruit list | Fruit detail | Settings |
|:-:|:-:|:-:|:-:|
| _screenshot_ | _screenshot_ | _screenshot_ | _screenshot_ |

## Features

- Onboarding carousel with animated fruit cards
- Fruit list in random order, with a detail screen for each fruit
- Nutritional values per 100 g in an expandable section
- Settings screen to restart the onboarding
- Fully localized in English and Spanish, including all fruit content
- VoiceOver labels, Dynamic Type and Reduce Motion support

## Tech stack

- SwiftUI, `NavigationStack` and the iOS 27 design system
- Swift 6 with strict concurrency
- MVVM with `@Observable` view models and a repository protocol for the data
- String Catalogs (`Localizable.xcstrings`, `FruitContent.xcstrings`)
- Swift Testing for the unit tests
- No third-party dependencies

## Project structure

```
Fruits/
├── App/            App entry point
├── Core/
│   ├── Models/     Fruit, Nutrient
│   ├── Data/       FruitRepository and its local implementation
│   ├── Services/   OnboardingStore (persists the onboarding state)
│   ├── Constants/  External links
│   ├── Extensions/
│   └── DesignSystem/
├── Features/
│   ├── FruitList/
│   ├── FruitDetail/
│   ├── Onboarding/
│   └── Settings/
└── Resources/      Assets, String Catalogs, privacy manifest
```

## Requirements

- Xcode 27 or later
- iOS 27 or later

## Credits

Built while following the SwiftUI Masterclass course by Robert Petras on Udemy. Source code is part of [SwiftiOSApps](https://github.com/DanielCazorro/SwiftiOSApps). Fruit descriptions are adapted from [Wikipedia](https://www.wikipedia.org).
