# Netflix Clone - Flutter App

## What the App Does

- **Home Screen**: Shows a featured hero movie banner, a previews row, and movie rails (Popular, Now Playing, Top Rated).
- **Search**: Search for any movie with quick debounced results, or browse popular top searches.
- **Coming Soon**: View upcoming movie trailers and release dates with quick "Remind Me" options.
- **Profiles & Settings**: Choose or switch user profiles, download settings, and more.

---

## Folder Structure

```text
lib/
├── core/                        # Network services, navigation, and utilities
│   ├── api/                     # Dio HTTP service
│   ├── navigation/              # Page transitions
│   └── utils/                   # Debouncer helper
├── shared/                      # Data models and repository classes
│   ├── models/                  # TMDB API response models
│   └── repository/              # Data fetching repositories
├── widget/                      # Reusable UI components
│   ├── featured_banner/
│   ├── movie_section/
│   ├── netflix_bottom_nav/
│   ├── previews_section/
│   ├── search_text_field/
│   └── shimmer_loading/
├── modules/                     # Feature screens & BLoC state management
│   ├── authorised/
│   │   ├── coming_soon/
│   │   ├── downloads/
│   │   ├── home/
│   │   ├── more/
│   │   ├── movie_detail/
│   │   └── search/
│   └── unauthorised/
│       ├── login_page/
│       └── splash_screen/
├── env.dart                     # Environment config & API credentials
└── main.dart                    # Application entry point
```

---

## Packages Used

Here are the main Flutter packages used in this project and why they are used:

- `flutter_bloc`: Manages the app state cleanly (loading, loaded, error, empty).
- `dio`: Handles all network requests to TMDB with headers and error handling.
- `shimmer`: Shows animated loading placeholder skeletons while data loads.
- `cupertino_icons`: Provides icons for the user interface.

---

## Setup & API Configuration

1. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

2. **API Configuration**:
   The API token and base URL are configured in `lib/env.dart`:
   ```dart
   class EnvConfig {
     String baseUrl = 'https://api.themoviedb.org/3';
     String apiToken = 'YOUR_TMDB_BEARER_TOKEN';
     String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
   }
   ```

3. **Run Application**:
   ```bash
   flutter run
   ```
