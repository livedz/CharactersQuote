# BB Quotes — Breaking Bad Universe App

> A SwiftUI iOS app that lets you explore random quotes, characters, deaths, and episodes from **Breaking Bad**, **Better Call Saul**, and **El Camino**.

---

## 📱 Demo

<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-05-26 at 16 04 47" src="https://github.com/user-attachments/assets/e5f8b03a-d32b-4566-a3e0-82b841ab4da0" />


https://github.com/user-attachments/assets/368eab80-7425-42d6-bed9-01895217d19f



---

## ✨ Features

- 🎲 **Random Quotes** — Fetch a surprise quote from any show in the universe
- 🧑‍🎤 **Character Profiles** — Full character detail including name, actor, birthday, occupations, and aliases
- 💀 **Death Info** *(Spoiler Alert!)* — Collapsible section revealing how a character died, with image and last words
- 🎬 **Random Episodes** — Browse episode cards with synopsis, writer, director, and air date
- 📺 **Three Shows Supported** — Breaking Bad, Better Call Saul, and El Camino via dedicated tabs
- 🌑 **Dark Mode** — Forced dark theme for that signature gritty aesthetic
- 🖼️ **Async Image Loading** — Remote character and episode images load seamlessly

---

## 🏗️ Architecture

This app follows **MVVM (Model-View-ViewModel)** with Swift Concurrency (`async/await`).

```
BB Quotes/
├── Models/
│   ├── Quote.swift          # Quote data model
│   ├── Char.swift           # Character + Death data models
│   ├── Episode.swift        # Episode data model
│   └── FetchService.swift   # Network layer (URLSession + async/await)
├── ViewModels/
│   └── ViewModel.swift      # @Observable state + fetch orchestration
├── View/
│   ├── MainView.swift       # Root TabView (BB / BCS / El Camino)
│   ├── FetchView.swift      # Main quote/episode fetch screen per show
│   ├── CharacterView.swift  # Full character detail sheet
│   └── EpisodeView.swift    # Episode info card
├── AppConstant.swift        # API URLs, tab config, utility helpers
└── Data/                    # Sample JSON files for Previews
```

---

## 🌐 API

All data is sourced from the public **Breaking Bad API**:

```
Base URL: https://breaking-bad-api-six.vercel.app/api
```

| Endpoint | Description |
|---|---|
| `GET /quotes/random?production=<show>` | Random quote for a show |
| `GET /characters?name=<name>` | Character info by name |
| `GET /deaths` | All character deaths |
| `GET /episodes?production=<show>` | Episodes list for a show |

---

## 🛠️ Tech Stack

| | |
|---|---|
| **Language** | Swift 5.9+ |
| **UI Framework** | SwiftUI |
| **State Management** | `@Observable` (iOS 17+) |
| **Concurrency** | Swift Concurrency (`async/await`, `Task`) |
| **Networking** | `URLSession` |
| **Min iOS Target** | iOS 17.0 |
| **IDE** | Xcode 15+ |

---

## 🚀 Getting Started

### Prerequisites

- macOS 14 (Sonoma) or later
- Xcode 15 or later
- iOS 17.0+ device or simulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/livedz/CharactersQuote.git
   cd CharactersQuote
   ```

2. **Open in Xcode**
   ```bash
   open "BB Quotes.xcodeproj"
   ```

3. **Select a target** — choose an iOS 17+ simulator or your device

4. **Run** — press `⌘R` or click the Run button

> No third-party dependencies or package manager setup required — everything uses Apple's native frameworks.

---

## 🧪 Testing

The project includes both unit tests and UI tests:

```bash
# Run all tests from Xcode
⌘U

# Or from the command line
xcodebuild test -project "BB Quotes.xcodeproj" \
  -scheme "BB Quotes" \
  -destination "platform=iOS Simulator,name=iPhone 16"
```

| Test Suite | Location |
|---|---|
| Unit Tests | `BB QuotesTests/BB_QuotesTests.swift` |
| UI Tests | `BB QuotesUITests/BB_QuotesUITests.swift` |

---

<img width="810" height="356" alt="Screenshot 2026-05-26 at 4 02 47 PM" src="https://github.com/user-attachments/assets/6901dc66-deb8-4e72-939d-0d418c1fa3b4" />

---

## 🗂️ Project Structure Notes

- **`AppConstant.swift`** — Centralises all API endpoint strings and tab configuration (`TabDetails`, `tabType`).
- **`FetchService.swift`** — Handles all network calls with detailed `DecodingError` logging per endpoint, making debugging API changes easy.
- **`ViewModel.swift`** — Single `@Observable` class annotated `@MainActor` to keep UI updates on the main thread. Provides `FetchStatus` enum to drive loading/success/error states.
- **`MockResources/`** — Local JSON files (`samplequote.json`, `samplecharacter.json`, etc.) power SwiftUI `#Preview` macros without requiring a network connection.

---

## 🙌 Acknowledgements

- [Breaking Bad API](https://breaking-bad-api-six.vercel.app/) for the data
- [Breaking Bad](https://www.amc.com/shows/breaking-bad), [Better Call Saul](https://www.amc.com/shows/better-call-saul), and [El Camino](https://www.netflix.com/title/80230399) — created by Vince Gilligan

---

## 📄 License

This project is for educational/personal use. All show-related content, characters, and imagery belong to their respective copyright holders (AMC Networks / Netflix / Sony Pictures Television).
