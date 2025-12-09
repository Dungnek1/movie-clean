# CineStream - Implementation Roadmap

**Fast Track: 3-4 Hours to Working Streaming App**

---

## 🗺️ Visual Roadmap

```
START
  ↓
[Phase 1: Video Player] ⏱️ 30 min
  ├─ Install chewie package
  ├─ Create PlayerPage
  ├─ Test with sample URL
  └─ ✅ Video plays
  ↓
[Phase 2: Movie Catalog] ⏱️ 45 min
  ├─ Choose content source
  ├─ Fetch movie list
  ├─ Display in grid
  └─ ✅ Movies browsable
  ↓
[Phase 3: Netflix UI] ⏱️ 1-2 hours
  ├─ Dark theme
  ├─ Hero banner
  ├─ Carousels
  └─ ✅ Looks like Netflix
  ↓
DONE: Streaming App Ready! 🎉
```

---

## 📋 Detailed Step-by-Step Guide

### **PHASE 1: Video Player Setup** (30 minutes)

#### Step 1.1: Install Packages (5 min)
```bash
# Add to pubspec.yaml dependencies:
chewie: ^1.8.1
video_player: ^2.8.2

# Then run:
flutter pub get
```

#### Step 1.2: Create PlayerPage (15 min)
```dart
// lib/src/presentation/pages/player_page.dart
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class PlayerPage extends StatefulWidget {
  final String videoUrl;
  final String movieTitle;

  // Initialize controllers
  // Build Chewie widget
  // Add dispose cleanup
}
```

#### Step 1.3: Test Video Streaming (5 min)
```dart
// Use free sample video
const testUrl = 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';

// Navigate to PlayerPage
context.push('/player', extra: testUrl);
```

#### Step 1.4: Add Route (5 min)
```dart
// lib/src/presentation/router/app_router.dart
GoRoute(
  path: '/player',
  name: 'player',
  builder: (context, state) {
    final videoUrl = state.extra as String;
    return PlayerPage(videoUrl: videoUrl);
  },
),
```

**✅ Phase 1 Complete:** Video streaming works!

---

### **PHASE 2: Movie Catalog** (45 minutes)

#### Step 2.1: Choose Content Source (10 min)

**Option A: Archive.org (Recommended)**
```dart
// Free API, no key needed
const apiUrl = 'https://archive.org/advancedsearch.php';
const query = 'collection:opensource_movies';
```

**Option B: Static JSON**
```dart
// Create assets/movies.json
const localJson = 'assets/movies.json';
```

**Option C: YouTube IDs List**
```dart
// List of YouTube video IDs
const youtubeIds = ['dQw4w9WgXcQ', 'abc123xyz'];
```

#### Step 2.2: Create Movie Model (10 min)
```dart
// Keep existing Movie entity, just ensure it has:
- id
- title
- overview
- posterUrl
- videoUrl (NEW - add this field)
- rating
- year
```

#### Step 2.3: Fetch Movies (15 min)
```dart
// Option A: Archive.org API call
Future<List<Movie>> fetchArchiveMovies() async {
  final response = await dio.get(archiveApiUrl);
  // Parse JSON
  // Return Movie list with videoUrl
}

// Option B: Load JSON asset
Future<List<Movie>> loadLocalMovies() async {
  final json = await rootBundle.loadString('assets/movies.json');
  // Parse and return
}
```

#### Step 2.4: Update HomePage (10 min)
```dart
// Display movies in GridView
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.7,
  ),
  itemCount: movies.length,
  itemBuilder: (context, index) {
    return MovieCard(movie: movies[index]);
  },
)
```

**✅ Phase 2 Complete:** Movies browsable!

---

### **PHASE 3: Netflix-Style UI** (1-2 hours)

#### Step 3.1: Dark Theme Setup (15 min)
```dart
// lib/main.dart
theme: ThemeData.dark().copyWith(
  primaryColor: Color(0xFFE50914), // Netflix red
  scaffoldBackgroundColor: Colors.black,
  cardColor: Color(0xFF1A1A1A),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0,
  ),
),
```

#### Step 3.2: Hero Banner Component (30 min)
```dart
// lib/src/presentation/widgets/hero_banner.dart
class HeroBanner extends StatelessWidget {
  // Full-width featured movie
  // Backdrop image with gradient
  // Title + overview overlay
  // "Play" and "More Info" buttons
}
```

#### Step 3.3: Movie Carousel (30 min)
```dart
// lib/src/presentation/widgets/movie_carousel.dart
class MovieCarousel extends StatelessWidget {
  // Horizontal ListView
  // Movie cards with hover effect
  // Category title (Popular, Trending, etc.)
}
```

#### Step 3.4: Enhanced Movie Card (15 min)
```dart
// lib/src/presentation/widgets/movie_card.dart
class MovieCard extends StatelessWidget {
  // Poster image (cached)
  // Title overlay on hover
  // Tap → navigate to DetailPage
  // Rounded corners, shadow
}
```

#### Step 3.5: Detail Page Redesign (30 min)
```dart
// lib/src/presentation/pages/detail_page.dart
// Backdrop image with gradient
// Large play button
// Movie info (title, year, rating)
// Overview text with "Read more"
// Similar movies section (optional)
```

**✅ Phase 3 Complete:** Netflix-style UI ready!

---

## 🎯 Checkpoints

After each phase, verify:

### After Phase 1:
- [ ] `flutter run` works without errors
- [ ] PlayerPage displays video player
- [ ] Sample video plays when opened
- [ ] Play/pause buttons work
- [ ] Seeking (scrubbing) works

### After Phase 2:
- [ ] HomePage shows movie grid
- [ ] Posters load correctly
- [ ] Tapping movie opens DetailPage
- [ ] "Play" button navigates to PlayerPage
- [ ] Video streams from movie data

### After Phase 3:
- [ ] App has dark theme
- [ ] Hero banner displays at top
- [ ] Carousels scroll horizontally
- [ ] UI looks polished and modern
- [ ] All interactions smooth

---

## 📦 Complete Package List

**Add to `pubspec.yaml`:**

```yaml
dependencies:
  flutter:
    sdk: flutter

  # State & Navigation (Existing)
  flutter_riverpod: ^2.5.1
  go_router: ^14.1.4
  dio: ^5.5.0

  # Video Streaming (NEW)
  chewie: ^1.8.1
  video_player: ^2.8.2

  # UI Enhancements (NEW)
  cached_network_image: ^3.3.1
  shimmer: ^3.0.0

  # Optional: YouTube support
  # youtube_player_flutter: ^9.0.3
```

---

## 🗂️ File Structure After Implementation

```
lib/
├── main.dart
└── src/
    ├── domain/
    │   ├── entities/
    │   │   └── movie.dart (add videoUrl field)
    │   └── repositories/
    │       └── movie_repository.dart (update methods)
    ├── data/
    │   ├── datasources/
    │   │   ├── archive_data_source.dart (NEW)
    │   │   └── movie_remote_data_source.dart (update)
    │   ├── models/
    │   │   └── movie_model.dart (add videoUrl)
    │   └── repositories/
    │       └── movie_repository_impl.dart (update)
    └── presentation/
        ├── pages/
        │   ├── home_page.dart (redesign with carousels)
        │   ├── detail_page.dart (add play button)
        │   └── player_page.dart (NEW)
        ├── widgets/
        │   ├── hero_banner.dart (NEW)
        │   ├── movie_carousel.dart (NEW)
        │   └── movie_card.dart (enhance)
        ├── providers/
        │   └── movie_providers.dart (update)
        └── router/
            └── app_router.dart (add player route)
```

**New Files:** 4
**Updated Files:** 8
**Total Changes:** Minimal, focused

---

## 🚀 Quick Start Commands

```bash
# 1. Add packages
flutter pub add chewie video_player cached_network_image shimmer

# 2. Get dependencies
flutter pub get

# 3. Run app
flutter run

# 4. Hot reload as you build
# Press 'r' in terminal
```

---

## 🎬 Content Source Setup

### Using Archive.org (Recommended)

**Step 1:** Test API in browser:
```
https://archive.org/advancedsearch.php?q=collection:opensource_movies&fl=identifier,title,description&output=json&rows=20
```

**Step 2:** Get video URL pattern:
```
https://archive.org/metadata/{identifier}
→ Extract video file URL from JSON
```

**Step 3:** Implement in Flutter:
```dart
final response = await dio.get('https://archive.org/metadata/$movieId');
final videoUrl = response.data['files'][0]['name']; // First video file
final fullUrl = 'https://archive.org/download/$movieId/$videoUrl';
```

### Using Static JSON

**Create `assets/movies.json`:**
```json
{
  "movies": [
    {
      "id": "1",
      "title": "Big Buck Bunny",
      "overview": "A giant rabbit seeks revenge on bullies.",
      "posterUrl": "https://via.placeholder.com/300x450",
      "videoUrl": "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      "rating": 7.5,
      "year": "2008"
    },
    {
      "id": "2",
      "title": "Elephant's Dream",
      "overview": "Two men explore a surreal machine.",
      "posterUrl": "https://via.placeholder.com/300x450",
      "videoUrl": "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      "rating": 6.8,
      "year": "2006"
    }
  ]
}
```

**Update `pubspec.yaml`:**
```yaml
flutter:
  assets:
    - assets/movies.json
```

---

## 🔍 Testing Strategy

### Manual Testing Checklist:
- [ ] Video plays on WiFi
- [ ] Video plays on mobile data
- [ ] Fullscreen mode works
- [ ] Rotation handled correctly
- [ ] App doesn't crash on network error
- [ ] Posters load and cache
- [ ] Navigation flows smoothly
- [ ] Back button works from player

### Test on Multiple Devices:
- [ ] Android phone (API 21+)
- [ ] iOS simulator/device
- [ ] Web browser (Chrome/Safari)
- [ ] Different screen sizes

---

## 💡 Tips & Best Practices

1. **Start Simple:** Use sample videos first, add real content later
2. **Test Early:** Run video player before building full UI
3. **Cache Aggressively:** Use cached_network_image for all posters
4. **Error Handling:** Show friendly messages on network errors
5. **Loading States:** Use shimmer effects while loading
6. **Performance:** Dispose video controllers properly
7. **Legal Content:** Only use licensed/public domain videos

---

## 🐛 Common Issues & Solutions

### Issue: Video not playing
**Solution:** Check URL is direct MP4/WebM link (not HTML page)

### Issue: Black screen on iOS
**Solution:** Add `NSAppTransportSecurity` to `Info.plist` for HTTP URLs

### Issue: Lag when scrolling
**Solution:** Use `cached_network_image` with `memCacheHeight` parameter

### Issue: Video continues after leaving page
**Solution:** Dispose video controller in `dispose()` method

---

## 📈 Success Metrics

| Metric | Target | How to Measure |
|--------|--------|----------------|
| Time to First Video | < 3 seconds | From app launch to video playing |
| Video Load Time | < 2 seconds | From tap to playback start |
| Smooth Scrolling | 60 FPS | Use Flutter DevTools |
| Crash Rate | < 1% | Test 100+ interactions |
| UI Responsiveness | < 100ms | Tap to action delay |

---

## 🎉 Launch Checklist

Before considering "done":
- [ ] All 3 phases completed
- [ ] App runs without errors
- [ ] Videos stream successfully
- [ ] UI looks polished
- [ ] Tested on 2+ devices
- [ ] No copyright violations
- [ ] README updated with setup instructions
- [ ] Code committed to git

---

## 🔄 What's Next? (Future)

Once MVP works, consider adding:

1. **Search** (30 min) - Filter existing movie list
2. **Categories** (45 min) - Group by genre/year
3. **Favorites** (1 hour) - Save with SharedPreferences
4. **Watch History** (1 hour) - Track viewed movies
5. **Better Player** (2 hours) - Upgrade to better_player for DRM

---

## 📚 Resources

- **Chewie Docs:** https://pub.dev/packages/chewie
- **Video Player:** https://pub.dev/packages/video_player
- **Archive.org API:** https://archive.org/help/aboutsearch.htm
- **Sample Videos:** http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/
- **Flutter Video Guide:** https://docs.flutter.dev/cookbook/plugins/play-video

---

## ✅ Ready to Start?

Run this command to begin:
```bash
/code plans/251205-1533-netflix-streaming-platform/SIMPLE-PLAN.md
```

Or ask questions about any phase!
