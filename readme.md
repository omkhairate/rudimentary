# Rudimentary

Rudimentary is a cat-themed bucket list app for couples who want to plan, track, and celebrate shared adventures. The SwiftUI code in this repository can be opened directly in Xcode to explore the app experience.

## Features

- 🐾 **Couple-focused planning** – Capture date ideas, cozy nights, acts of kindness, and big dreams with playful feline flair.
- 🎯 **Smart filtering** – Search, filter by category, and toggle completed adventures to stay organized.
- 💖 **Progress insights** – Animated mood header and progress ring celebrate milestones and encourage the next memory.
- ✍️ **Love notes** – Attach sweet reminders or prompts to each idea to personalize the journey.
- 📱 **SwiftUI-first** – Built with declarative SwiftUI views, preview support, and modular components ready for adaptation.

## Project structure

```
Rudimentary/
├── Models/
│   ├── BucketItem.swift
│   ├── CatCategory.swift
│   └── ThemeColor.swift
├── ViewModels/
│   └── BucketListViewModel.swift
├── Views/
│   ├── AddBucketItemView.swift
│   ├── BucketItemCard.swift
│   ├── CatMoodHeader.swift
│   ├── CategoryPill.swift
│   ├── ContentView.swift
│   ├── CoupleProgressView.swift
│   ├── EmptySectionView.swift
│   └── PawPrintBackground.swift
├── Resources/
│   └── Assets.xcassets/
└── RudimentaryApp.swift
```

To run the project, create a new **App** project in Xcode (iOS ➜ App, interface SwiftUI) named `Rudimentary`, then replace the generated files with the ones from this repository.
