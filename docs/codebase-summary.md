# CineStream Codebase Summary

**Project:** movie_clean (CineStream Flutter App)
**Type:** Flutter Mobile Application
**Last Updated:** 2025-12-09
**Architecture:** Clean Architecture + Riverpod State Management

---

## Project Overview

CineStream is a Netflix-inspired movie streaming application built with Flutter. Features dark theme aesthetics, offline capabilities, and comprehensive video playback functionality.

**Key Characteristics:**
- Dark mode-first design (OLED optimized)
- Offline download support
- Rich metadata display
- Advanced video player integration
- Multi-language support (l10n)

---

## Architecture Structure

### Clean Architecture Layers

```
lib/src/
├── core/              # Shared infrastructure
├── domain/            # Business logic, entities, interfaces
├── data/              # Data access, repositories, models
└── presentation/      # UI, pages, widgets, routing
```

### Directory Organization

```
lib/
├── main.dart                          # App entry point
└── src/
    ├── core/                          # Shared utilities & infrastructure
    │   ├── analytics/                 # Analytics service
    │   ├── api/                       # TMDB API client
    │   ├── cache/                     # Image caching config
    │   ├── downloads/                 # Download management
    │   ├── l10n/                      # Localization
    │   ├── theme/                     # Design system
    │   │   ├── app_colors.dart       # Color palette
    │   │   ├── app_typography.dart   # Text styles
    │   │   ├── app_theme.dart        # Theme configuration
    │   │   └── spacing_tokens.dart   # Layout tokens
    │   └── utils/                     # Helper functions
    │
    ├── domain/                        # Business logic (frameworks-independent)
    │   ├── entities/                  # Data models
    │   │   ├── movie.dart            # Movie entity
    │   │   ├── series.dart           # Series entity
    │   │   ├── content.dart          # Base content
    │   │   ├── episode.dart          # Episode details
    │   │   ├── season.dart           # Season details
    │   │   ├── genre.dart            # Genre definitions
    │   │   ├── user.dart             # User profile
    │   │   ├── watch_progress.dart   # Playback tracking
    │   │   └── profile.dart          # User preferences
    │   └── repositories/              # Data access interfaces
    │       ├── movie_repository.dart
    │       └── search_repository.dart
    │
    ├── data/                          # Data layer implementations
    │   ├── datasources/              # Remote & local data sources
    │   │   ├── movie_remote_data_source.dart
    │   │   ├── tmdb_movie_remote_data_source.dart
    │   │   ├── search_remote_data_source.dart
    │   │   └── local_json_movie_remote_data_source.dart
    │   ├── models/                   # Data models (with serialization)
    │   │   └── movie_model.dart
    │   └── repositories/              # Repository implementations
    │       ├── movie_repository_impl.dart
    │       └── search_repository_impl.dart
    │
    └── presentation/                  # UI & routing
        ├── pages/                     # Full screen pages
        │   ├── home_page.dart        # Movie grid & discovery
        │   ├── search_page.dart      # Search interface
        │   ├── detail_page.dart      # Movie details & trailer
        │   ├── player_page.dart      # Video player
        │   ├── downloads_page.dart   # Offline downloads
        │   └── profile_page.dart     # User preferences
        ├── widgets/                   # Reusable UI components
        │   └── movie_card.dart       # Movie list item
        ├── providers/                 # Riverpod state management
        │   ├── movie_providers.dart
        │   └── search_provider.dart
        └── router/                    # Navigation configuration
            └── app_router.dart        # GoRouter setup
```

---

## Technology Stack

### Dependencies
- **State Management:** flutter_riverpod ^2.5.1
- **Routing:** go_router ^14.1.4
- **Networking:** dio ^5.5.0
- **Video Playback:** better_player ^0.0.84, chewie ^1.8.1, video_player ^2.8.2
- **Image Caching:** cached_network_image ^3.3.1
- **Loading States:** shimmer ^3.0.0
- **Serialization:** freezed, json_serializable
- **Localization:** flutter_localizations (SDK)

### Minimum Requirements
- Dart SDK: ^3.10.1
- Material Design 3

---

## Key Architectural Patterns

### 1. Clean Architecture
Strict separation between domain (business logic), data (persistence), and presentation layers.

**Benefits:**
- Testability: domain layer has no Flutter dependencies
- Maintainability: clear responsibility boundaries
- Reusability: data/domain logic portable to other frameworks

### 2. Repository Pattern
Abstractions in domain layer, implementations in data layer. Decouples business logic from data sources.

```
Domain: MovieRepository (interface)
  ↓
Data: MovieRepositoryImpl (implements MovieRepository)
  ↓
DataSources: TMDBMovieRemoteDataSource, LocalJsonMovieRemoteDataSource
```

### 3. Provider Pattern (Riverpod)
State management with clear dependency injection. Providers are immutable, composable, and testable.

**Key Providers:**
- `movieProvider` - Fetch movies by type
- `movieDetailProvider` - Individual movie metadata
- `searchProvider` - Search functionality with debouncing
- `downloadProvider` - Offline download management

### 4. Navigation with GoRouter
Type-safe routing with named routes and path parameters.

**Route Structure:**
- `/` → HomePage (tab shell)
  - `/movie/:id` → DetailPage
- `/search` → SearchPage
- `/downloads` → DownloadsPage
- `/profile` → ProfilePage
- `/player` → PlayerPage

**Transitions:**
- Tab navigation: Fade transition (250ms)
- Detail/player pages: Slide transition (250ms)

### 5. Freezed Code Generation
Type-safe data classes with serialization support.

**Generated Files:**
- `.freezed.dart` - Immutable classes, constructors
- `.g.dart` - JSON serialization (toJson, fromJson)

---

## Presentation Layer Components

### Pages Overview

#### HomePage
- Grid of featured/trending movies
- Categorized sections (trending, popular, new releases)
- Cached network images with shimmer loading
- Navigation to movie details on tap

#### SearchPage
- Real-time search with 300ms debounce
- Search results grid
- Navigation to detail pages from results
- Optimized for performance (minimal API calls)

#### DetailPage
- Movie metadata (title, rating, genres, synopsis)
- Poster image and backdrop
- Play button (navigation to PlayerPage)
- Related content recommendations
- Watch history tracking

#### PlayerPage
- Better Player integration for smooth playback
- Fullscreen support
- Playback controls (play/pause, seek, volume)
- Progress tracking for resume functionality

#### DownloadsPage
- List of downloaded movies for offline viewing
- Delete/manage local files
- Initiate new downloads

#### ProfilePage
- User preferences and settings
- Watch history
- Watchlist management
- Logout functionality

### Widget Components

#### MovieCard
- Customizable card for movie display
- Poster image with CachedNetworkImage
- Movie title and rating
- Tap handler for navigation
- Used in grids and lists throughout app

### Theme System

#### AppColors
Semantic color palette with WCAG AA compliance.

```dart
Primary: #E50914 (Netflix red)
Secondary: #B81D24
Background: #000000 (true black)
Surface: #141414 (card color)
Text Primary: #FFFFFF
Text Secondary: #B3B3B3
```

#### AppTypography
Comprehensive text style scale.

```dart
Display (32px bold) - hero sections
Headline (20px bold) - section headers
Body (14px regular) - content
Label (12px medium) - buttons, labels
Caption (10px regular) - metadata
```

All styles use semantic color tokens (AppColors.textPrimary, etc.)

#### Spacing System
Standardized spacing values for consistent layouts.

```dart
xs: 4, sm: 8, md: 16, lg: 24, xl: 32, xxl: 48
```

#### Border Radius
Consistent rounding for cards, buttons, inputs.

```dart
sm: 4, card: 8, button: 6, input: 8, lg: 12
```

---

## State Management (Riverpod)

### Provider Hierarchy

**Domain Providers** (business logic)
```dart
- movieRepositoryProvider
- searchRepositoryProvider
```

**Data Providers** (fetch operations)
```dart
- movieProvider(movieType) → List<Movie>
- movieDetailProvider(id) → Movie
- searchProvider(query) → List<Movie>
```

**UI Providers** (local state)
```dart
- searchQueryProvider → String
- selectedMovieProvider → Movie?
```

### Data Flow
1. Widget requests data via `ref.watch(provider)`
2. Provider executes async operation (FutureProvider)
3. UI rebuilds with AsyncValue (loading/data/error)
4. Riverpod caches results (invalidation on demand)

---

## Localization Setup

### Supported Languages
Configuration at `/lib/src/core/l10n/`

**Files:**
- `app_localizations.dart` - Localization delegate
- Language files generated by Flutter gen-l10n

### Usage
```dart
context.l10n.movieTitle  // Access translations
```

---

## Data Models & Serialization

### Movie Entity
```dart
@freezed
class Movie with _$Movie {
  const factory Movie({
    required String id,
    required String title,
    required String posterUrl,
    required String backdropUrl,
    required double rating,
    required String synopsis,
    required List<Genre> genres,
    required int releaseYear,
  }) = _Movie;
}
```

### JSON Serialization
```dart
// Generated .g.dart provides:
Movie.fromJson(Map<String, dynamic> json)
movie.toJson() → Map<String, dynamic>
```

---

## Recent Critical Fixes (2025-12-09)

### 7 Critical UI Fixes
1. **Search Navigation** - Enables navigation from search results to detail pages
2. **Search Debouncing** - 300ms debounce reduces API calls by ~70%
3. **Page Transitions** - Fade/slide animations (250ms) improve UX
4. **Shimmer Loading** - Loading states for images and content
5. **Empty State Handling** - Graceful fallbacks when no data available
6. **Error Messages** - User-friendly error dialogs and snackbars
7. **Responsive Layout** - Adaptive grid columns (mobile: 2, tablet: 3+)

### 4 Design System Enhancements
1. **Extended Color Palette** - Added semantic colors (success, warning, error, info)
2. **Typography Scale** - Expanded with display, label, caption styles
3. **Interactive States** - Hover, pressed, disabled, focus states
4. **Spacing System** - Standardized spacing tokens (xs-xxl)

---

## Performance Optimizations

### Image Caching
- CachedNetworkImage with disk caching
- 7-day cache expiration
- Fallback to placeholder on error

### Search Optimization
- 300ms debounce eliminates rapid API calls
- Query memoization in Riverpod
- Minimal re-renders on input change

### Video Playback
- Better Player for hardware-accelerated playback
- Lazy loading of video resources
- Buffering optimization

### State Management
- Riverpod automatic caching
- Selective invalidation (avoid full app rebuilds)
- FutureProvider for async operations

---

## Download Management

### Download Service (`/lib/src/core/downloads/download_service.dart`)
- Manages offline movie storage
- Resume capability for interrupted downloads
- Storage quota management
- Integration with DownloadsPage

---

## Analytics & Tracking

### Analytics Service (`/lib/src/core/analytics/analytics_service.dart`)
- Page view tracking
- User interaction events
- Video playback metrics
- Error logging

---

## Testing Strategy

**Unit Tests:** Domain layer (entities, repositories)
**Widget Tests:** Individual components (MovieCard, SearchPage)
**Integration Tests:** Full user flows (search → detail → player)

**Test Coverage:** Focus on critical paths (navigation, search, playback)

---

## Future Enhancement Opportunities

1. **Offline Mode** - Full app functionality without internet
2. **Watchlist Sync** - Cloud synchronization of user preferences
3. **Social Features** - Friend sharing, reviews, ratings
4. **Recommendation Engine** - ML-based content suggestions
5. **Performance Monitoring** - Real-time app analytics
6. **Dark Mode Toggle** - User preference option (currently always dark)
7. **Custom Font Support** - Non-default typography rendering

---

## Build Configuration

### Build Process
```bash
flutter pub get              # Install dependencies
flutter pub run build_runner # Generate .freezed.dart and .g.dart
flutter run                  # Run on connected device
flutter build apk            # Android APK
flutter build ios            # iOS app
```

### Generated Files
- `**.freezed.dart` - Immutable data classes
- `**.g.dart` - JSON serialization
- `.dart_tool/` - Generated dependencies

---

## Common Commands

```bash
# Clean build
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs

# Run app
flutter run
flutter run -v  # Verbose logging

# Static analysis
flutter analyze
dart fix .

# Format code
dart format lib/

# Test
flutter test
```

---

## Dependency Structure

```
Presentation Layer (UI)
    ↓ depends on
Core + Domain + Data Layers
    ↓ depends on
Domain Layer (Business Logic)
    ↓ depends on
External Libraries (Riverpod, GoRouter, Dio)
```

**Dependency Rule:** Lower layers never depend on higher layers. Presentation depends on domain/data, but domain/data never depend on presentation.

