# Flutter Video Streaming Packages Research Report
**Date:** 2025-12-05 | **Status:** Comprehensive Analysis | **Token Efficiency:** Optimized

---

## 1. VIDEO PLAYER PACKAGES COMPARISON

| Package | Version | Platform | Pros | Cons |
|---------|---------|----------|------|------|
| **video_player** | Official | iOS/Android/Web | Official Flutter plugin, foundation for others, lightweight | Limited UI controls, basic streaming |
| **better_player** | 0.0.84 | iOS/Android | HLS/DASH, DRM (Widevine/FairPlay), PIP, subtitles, playlists, DRM-protected content | In-progress development, breaking changes possible |
| **chewie** | 1.3+ | iOS/Android/Web | Material/Cupertino UI, subtitle support (SRT/WEBVTT), highly customizable, active community | UI-focused only (wraps video_player), less streaming features |
| **fijkplayer** | ijkplayer-based | iOS/Android | Multi-protocol support, codec flexibility, low-level control | Less actively maintained than alternatives |
| **media_kit** | Latest | iOS/Android/Web | Modern API, cross-platform, codec support | Newer, smaller ecosystem |

**Recommendation:** Use **better_player** (0.0.84) for Netflix-like features (DRM, HLS/DASH, PIP, subtitles). Combine with **cached_video_player_plus** for caching.

---

## 2. STREAMING SUPPORT (HLS/DASH)

**Native Streaming Support:**
- **better_player**: Full HLS/DASH support with adaptive bitrate, track selection, embedded subtitles
- **flutter_hls_video_player**: HLS-specialized, adaptive bitrate, custom controls
- **zeroratehls**: Feature-rich HLS player (seek preview, quality selection, PIP)
- **video_player**: Basic HLS/DASH (requires proper stream config for adaptive bitrate)

**Adaptive Bitrate:** Native support in HLS/DASH formats; adjusts quality based on bandwidth automatically.
**Subtitle Support:** SRT, WEBVTT, embedded in HLS streams (via better_player).

---

## 3. STATE MANAGEMENT (Riverpod Integration)

**Best Practices for Video Streaming with Riverpod:**

```dart
// Video playback state provider
final videoPlayerProvider = StateNotifierProvider<VideoPlayerNotifier, VideoPlayerState>((ref) {
  return VideoPlayerNotifier();
});

// Progress tracking
final playbackProgressProvider = StreamProvider<Duration>((ref) async* {
  // Stream playback position
});

// Playlist management
final playlistProvider = StateNotifierProvider<PlaylistNotifier, List<Video>>((ref) {
  return PlaylistNotifier();
});
```

**Key Considerations:**
- Separate controller lifecycle from UI lifecycle
- Use `StateNotifierProvider` for mutable playback state
- Use `StreamProvider` for real-time progress updates
- Implement proper cleanup in `.dispose()`

---

## 4. CACHING & OFFLINE PLAYBACK

**Top Packages:**

| Package | Purpose | Best For |
|---------|---------|----------|
| **cached_video_player_plus** | Drop-in video_player replacement | Seamless caching + playback |
| **flutter_cache_manager** | Generic file caching | API responses, images, documents |
| **flutter_video_cache** | Video-specific caching | Download tracking, offline resume |
| **media_cache_manager** | Media caching with encryption | Secure cache with auto-expiration |
| **dio_cache_interceptor** | HTTP request caching | API data caching with Dio |

**Critical Limitation:** HLS streams are NOT cacheable; use progressive downloads instead.

**Implementation Strategy:**
- Use `cached_video_player_plus` for streaming video caching
- Use `flutter_cache_manager` for API responses, thumbnails
- Combine with `Hive` or `sqflite` for metadata persistence
- Implement expiration policies (e.g., 30-day auto-delete)

---

## 5. AUTHENTICATION & SECURITY

**JWT Token Management:**

| Package | Purpose | Details |
|---------|---------|---------|
| **flutter_secure_storage** | Secure token storage | Keychain (iOS), KeyStore (Android), WebCrypto (Web-experimental) |
| **jwt_auth** | JWT handling | Wraps flutter_secure_storage, handles token renewal |
| **dio_http_cache** | HTTP request caching | For API token-based requests |

**Best Practice Flow:**
1. Store JWT in `flutter_secure_storage` (encrypted)
2. Use `jwt_auth` for automatic token refresh
3. Implement refresh token rotation
4. Add certificate pinning for iOS/Android via custom Dio interceptors

**OAuth 2.0:** Use `google_sign_in`, `firebase_auth` for provider integration.

---

## 6. UI & UTILITY PACKAGES

| Package | Version | Purpose | Notes |
|---------|---------|---------|-------|
| **cached_network_image** | Latest | Image caching/loading | Efficient thumbnail caching |
| **shimmer** | Latest | Skeleton loading | UX improvement during load |
| **flutter_animate** | Latest | Smooth animations | Fade, slide transitions |
| **readmore** | Latest | Text truncation | Show more/less for descriptions |
| **percent_indicator** | Latest | Progress indicators | Custom buffering UI |
| **riverpod** | Latest | State management | Core dependency for architecture |

---

## 7. ESSENTIAL DEPENDENCY STACK

**Core Stack:**
```yaml
dependencies:
  flutter:
    sdk: flutter

  # Video & Streaming
  better_player: ^0.0.84
  cached_video_player_plus: ^latest

  # Caching & Storage
  flutter_cache_manager: ^latest
  hive: ^latest
  hive_flutter: ^latest

  # Auth & Security
  flutter_secure_storage: ^latest
  jwt_auth: ^latest
  dio: ^latest
  dio_cache_interceptor: ^latest

  # State Management
  riverpod: ^latest
  riverpod_annotation: ^latest
  hooks_riverpod: ^latest

  # UI & UX
  cached_network_image: ^latest
  shimmer: ^latest
  flutter_animate: ^latest
```

---

## 8. IMPLEMENTATION PRIORITIES

**Phase 1 (MVP):**
- `better_player` + `cached_video_player_plus` for playback/caching
- `flutter_secure_storage` + `jwt_auth` for auth
- `riverpod` for state management
- `cached_network_image` for thumbnails

**Phase 2 (Enhancement):**
- Add `shimmer` for skeleton loading
- Implement `flutter_animate` for transitions
- Add `media_cache_manager` for offline mode

**Phase 3 (Advanced):**
- Picture-in-picture via better_player
- DRM content support (Widevine/FairPlay)
- Advanced subtitle/audio track selection

---

## 9. PACKAGE VERSION STATUS (2025)

- **better_player:** 0.0.84 (active, in-progress)
- **video_player:** Maintained by Google
- **chewie:** 1.3+ (community-maintained, stable)
- **fijkplayer:** Stable but less active
- **flutter_secure_storage:** Maintained, web support experimental
- **riverpod:** 2.x+ (fully stable)

---

## SUMMARY

**Recommended Core Stack for Netflix-like App:**
1. **Video Playback:** better_player (HLS/DASH, DRM, PIP, subtitles)
2. **Caching:** cached_video_player_plus + flutter_cache_manager
3. **Security:** flutter_secure_storage + jwt_auth
4. **State Mgmt:** riverpod with StateNotifierProvider
5. **UI:** cached_network_image + shimmer + flutter_animate

**Key Trade-offs:**
- better_player has breaking changes risk but offers Netflix-feature parity
- HLS caching requires workarounds (progressive downloads)
- flutter_secure_storage web support is experimental; consider secure cookies for web

---

## UNRESOLVED QUESTIONS

1. What is the exact DRM license server architecture (Widevine/FairPlay)?
2. Which video CDN will be used (AWS CloudFront, Cloudflare, custom)?
3. Are offline downloads required or caching only?
4. Web platform requirements—how critical is flutter_secure_storage web support?
5. What's the maximum offline cache size target?

---

## SOURCES

- [Flutter Gems - Video Players](https://fluttergems.dev/video/)
- [better_player on pub.dev](https://pub.dev/packages/better_player)
- [Chewie - Flutter Community](https://github.com/fluttercommunity/chewie)
- [Dolby OptiView Webinar - Flutter Video Playback 2025](https://optiview.dolby.com/resources/blog/playback/webinar-recap-flutter-video-playback-trends-challenges-and-player-comparison/)
- [VDOCipher - Flutter Video Streaming Guide](https://www.vdocipher.com/blog/flutter-video-streaming/)
- [Flutter Gems - Cache Management](https://fluttergems.dev/cache-temporary-storage/)
- [cached_video_player_plus on pub.dev](https://pub.dev/packages/cached_video_player_plus)
- [flutter_cache_manager on pub.dev](https://pub.dev/packages/flutter_cache_manager)
- [flutter_secure_storage on pub.dev](https://pub.dev/packages/flutter_secure_storage)
- [Medium - Flutter JWT Best Practices](https://medium.com/@rk0936626/i-found-some-best-ways-to-store-jwt-json-web-token-in-flutter-a72b93e8eba2)
