# SafeGuard Nigeria

A cross-platform emergency contact directory covering all 36 Nigerian states and the FCT, built with Flutter. SafeGuard puts Police, Fire, and Hospital contact numbers for any state one tap away, with one-touch calling and instant search.

Originally developed as part of a university systems engineering project (CPE 407); I designed and built the application.

## Features

- **Full national coverage** — 90 verified emergency contacts across all 36 states, the FCT, and national toll-free lines (Police, Fire, Health, Road Safety)
- **Instant state search** — live-filtered search across all states as you type
- **One-tap calling** — tapping a contact launches the device dialer directly via `tel:` URI, with a graceful fallback message on unsupported platforms (e.g. desktop)
- **Category-coded contacts** — Police, Fire, and Hospital entries are visually distinguished by color and icon for fast scanning in an emergency
- **Responsive layout** — adapts across desktop, tablet, and mobile browsers
- **Crisis response infographics** — built-in visual guides screen
- **About / feedback screens** — project info and a contact channel for user feedback

## Tech Stack

- **Framework:** [Flutter](https://flutter.dev/) (Web target)
- **Language:** Dart
- **Key packages:** `url_launcher` (device dialing), `google_fonts` / custom Montserrat font family, `http`

## Project Structure

```
lib/
├── main.dart                   # App entry point & theme
├── models/
│   └── contact.dart            # Contact data model
├── data/
│   └── emergency_data.dart     # 90-entry emergency contact database
└── screens/
    ├── home_page.dart              # Landing page
    ├── state_selection_screen.dart # Searchable state grid
    ├── state_detail_screen.dart    # Per-state contact list + one-tap calling
    ├── infographics_screen.dart    # Crisis response visual guides
    ├── about_us_screen.dart        # Project info
    └── contact_us_screen.dart      # Feedback / contact links
```

## Running Locally

```bash
flutter pub get
flutter run -d chrome
```

## Roadmap

- [ ] Print-friendly CSS layout for offline/physical posting
- [ ] Geo-based auto-detection of user's state

## License

MIT
