# Dunkin' PH Menu 🇵🇭🍩

An unofficial pocket guide to the **Dunkin' Donuts Philippines** menu — browse
104 items across 9 categories with prices in Philippine Peso (₱).

## 📱 Download

**Get the APK for Android:**

👉 [Download dunkin-ph-menu.apk (v1.0.0)](https://github.com/kumargaurav6/dunkin-ph-menu/releases/download/v1.0.0/dunkin-ph-menu.apk)

> Requires Android 5.0 (Lollipop) or higher, 64-bit (arm64) device.

## Features

- **Home** — greeting header, menu search shortcut, category cards,
  "Popular right now" carousel, and a Combos & bundles section.
- **Menu** — scrollable category tabs (Classic, Premium, Supreme, Munchkins,
  Bundles & Dozens, Coffee, Iced Drinks, Savory & Bunwich, Combos & Shareables)
  with item cards showing image, description, price, and a favorite heart.
- **Item details** — large image, price card, tags, popular badge, favorite
  button, and "You may also like" similar items.
- **Search** — live search across names, descriptions, and tags.
- **Favorites** — items saved on-device with SharedPreferences; swipe to remove.
- **About** — app version, disclaimer, and data note.

## Project structure

```
lib/
  main.dart                  # App entry, theme + favorites wiring
  theme/app_theme.dart       # Brand colors + ThemeData
  models/
    menu_item.dart           # MenuItem model
    category.dart            # MenuCategory model
  data/menu_data.dart        # Full menu dataset (104 items) + query helpers
  utils/peso.dart            # formatPeso() → ₱ with 2 decimals
  services/favorites_service.dart  # Favorites persistence (ChangeNotifier)
  screens/
    splash_screen.dart       # Branded splash, 1.5s
    main_shell.dart          # Bottom nav: Home / Menu / Favorites / About
    home_screen.dart         # Home content
    menu_screen.dart         # Category tabs + item lists
    item_detail_screen.dart  # Item detail
    search_screen.dart       # Live search
    favorites_screen.dart    # Saved items
    about_screen.dart        # About + disclaimer
  widgets/
    item_card.dart           # Horizontal item card
    category_card.dart       # Category card
    section_header.dart      # Section title row
    favorite_button.dart     # Live favorite heart
assets/images/              # Category artwork (added separately)
android/                    # Android config (applicationId com.dunkinph.menu)
```

## Build

Requirements: Flutter SDK 3.35+ with Android SDK.

```bash
flutter pub get
flutter run                 # debug on a device/emulator
flutter build apk --release # release APK -> build/app/outputs/flutter-apk/
flutter build appbundle     # Play Store bundle
```

## Data source note

Menu items and prices were compiled in September 2026 from publicly available
Dunkin' Donuts Philippines menu information. Prices may vary by branch and are
subject to change. This is an unofficial fan-made guide, not affiliated with
Dunkin' Donuts Philippines.
