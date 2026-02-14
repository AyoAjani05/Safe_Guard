# Safe Guard (Emergency Contact Directory Web App) 

## Project Overview

**CPE 407 Group 2 Project | Status: In Development**

The **Emergency Contact Directory** will be a cross-platform web application built with Flutter. It is being designed to serve as a reliable, centralized hub for emergency information across the country. By providing a clean, accessible interface, the app will ensure that critical contact details for **Police, Fire Services, and Hospitals** for all states are never more than a click away.

## Planned Features

* **Nationwide Geo-Fencing:** The app **will provide** dedicated contact directories for every state, moving beyond regional limitations to ensure national coverage.
* **Intuitive Search Interface:** Users **will be able to** quickly filter through states and emergency departments using a responsive search bar.
* **One-Click Dialing:** Since it is a web app, it **will leverage** browser-based URI schemes to allow users on mobile browsers to initiate calls with a single tap.
* **Print-Friendly Directory:** A core feature **will be** the ability to generate clean, printer-ready pages of state-specific contacts for physical posting in homes or offices.
* **Responsive Web Design:** The layout **will adapt** seamlessly to desktop, tablet, and mobile browsers to ensure accessibility on any device.

## Tech Stack

* **Framework:** [Flutter for Web](https://flutter.dev/multi-platform/web)
* **Language:** Dart
* **Key Packages:**
* `url_launcher`: For handling "tel:" links and external web redirects.
* `google_fonts`: For clear, professional typography.



## Proposed Project Structure

```text
Safe_Guard/
└── lib/
    ├── main.dart                 # App entry point & Custom font family Theme
    ├── home_page.dart              # Landing page (contains Geo/IP logic)
    ├── state_selection_screen.dart # Directory for all 36 States + FCT
    ├── state_detail_screen.dart    # Detailed agency contacts per state
    ├── about_us_screen.dart        # Project mission & info
    ├── contact_us_screen.dart      # Feedback & external link logic
    └── infographics_screen.dart    # Crisis response visual guides
└── fonts/                        # Custom font family files (weights 200-900)

```

##  Development Roadmap

* [x] Compile a comprehensive database of emergency numbers for all states.
* [x] Develop the Flutter Web responsive grid layout.
* [x] Implement search and state-filtering logic.
* [ ] Optimize the UI for print-friendly CSS/Media queries.
