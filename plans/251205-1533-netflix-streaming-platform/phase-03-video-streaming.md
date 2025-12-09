# Phase 03: Video Streaming

**Parent:** [plan.md](./plan.md) | **Priority:** P0 | **Status:** Planned

---

## Context

**Dependencies:** Phase 01 (Content entities), Phase 02 (Auth for protected streams)
**Research:** [Streaming Architecture](./research/researcher-01-streaming-architecture.md), [Flutter Packages](./research/researcher-02-flutter-packages.md)

---

## Overview

Integrate video player with HLS/DASH adaptive streaming, playback controls, and picture-in-picture support.

**Estimated Duration:** 5-6 days

---

## Key Insights

- better_player (0.0.84): Best Flutter option for HLS/DASH/DRM/PIP
- Adaptive bitrate automatic based on bandwidth
- Subtitle support: SRT, WEBVTT, embedded HLS
- Track progress for "Continue Watching" feature

---

## Requirements

**Functional:**
- Play HLS/DASH streams with adaptive bitrate
- Netflix-style controls (10s skip, volume, brightness)
- Quality selector (Auto/720p/1080p/4K)
- Subtitle/audio track selection
- Picture-in-picture mode
- Resume from last position
- Episode auto-play (series)

**Technical:**
- better_player integration
- Playback state management via Riverpod
- Progress tracking (save every 10s)
- Fullscreen handling
- Orientation lock during playback

---

## Architecture

### Player State
```dart
VideoPlayerState
├── idle           # No content loaded
├── loading        # Buffering
├── playing        # Active playback
├── paused         # User paused
├── completed      # Finished
└── error(msg)     # Playback error

PlaybackInfo
├── contentId: String
├── position: Duration
├── duration: Duration
├── buffered: Duration
├── quality: VideoQuality
├── subtitleTrack: SubtitleTrack?
├── audioTrack: AudioTrack?
└── isFullscreen: bool
```

### Component Structure
```
VideoPlayerScreen
├── BetterPlayer (core)
├── CustomControlsOverlay
│   ├── PlayPauseButton
│   ├── ProgressBar
│   ├── Skip10sButtons
│   ├── QualitySelector
│   ├── SubtitleSelector
│   ├── VolumeSlider
│   └── FullscreenButton
├── BufferingIndicator
└── EpisodeSelector (series only)
```

---

## Related Code Files

### Existing (Modify)
- `lib/src/presentation/router/app_router.dart` - Add player route

### New Files
```
lib/src/domain/
├── entities/playback_info.dart
└── repositories/playback_repository.dart

lib/src/data/
├── datasources/playback_local_data_source.dart
└── repositories/playback_repository_impl.dart

lib/src/presentation/
├── providers/video_player_provider.dart
├── pages/video_player_page.dart
├── widgets/player/
│   ├── custom_controls_overlay.dart
│   ├── progress_bar.dart
│   ├── quality_selector.dart
│   ├── subtitle_selector.dart
│   ├── episode_list.dart
│   └── buffering_indicator.dart
└── utils/
    └── orientation_helper.dart

lib/src/core/
└── services/playback_service.dart
```

---

## Implementation Steps

1. Add better_player ^0.0.84 to pubspec.yaml
2. Configure iOS/Android for PIP support (Info.plist, AndroidManifest)
3. Create PlaybackInfo entity
4. Create PlaybackRepository for progress persistence
5. Create PlaybackLocalDataSource using Hive
6. Create VideoPlayerNotifier (StateNotifier)
7. Create VideoPlayerPage with BetterPlayer widget
8. Implement CustomControlsOverlay matching Netflix
9. Create ProgressBar with buffering visualization
10. Create QualitySelector dropdown
11. Create SubtitleSelector with track list
12. Implement progress saving (10s interval)
13. Implement resume logic (fetch last position on load)
14. Handle fullscreen + orientation
15. Configure PIP for Android/iOS
16. Create EpisodeList for series playback
17. Implement auto-play next episode

---

## Todo List

- [ ] Add better_player ^0.0.84
- [ ] Configure iOS Info.plist for PIP
- [ ] Configure Android manifest for PIP
- [ ] Create PlaybackInfo entity
- [ ] Create PlaybackRepository interface
- [ ] Create PlaybackLocalDataSource
- [ ] Implement PlaybackRepositoryImpl
- [ ] Create VideoPlayerNotifier
- [ ] Create VideoPlayerPage
- [ ] Create CustomControlsOverlay
- [ ] Create ProgressBar widget
- [ ] Create QualitySelector
- [ ] Create SubtitleSelector
- [ ] Implement progress auto-save
- [ ] Implement resume playback
- [ ] Handle fullscreen transitions
- [ ] Configure orientation handling
- [ ] Implement PIP mode
- [ ] Create EpisodeList widget
- [ ] Implement auto-play next
- [ ] Test HLS stream playback
- [ ] Test DASH stream playback

---

## Success Criteria

- [ ] HLS/DASH streams play without stuttering
- [ ] Quality adapts to network conditions
- [ ] Subtitles display correctly
- [ ] Progress persists across sessions
- [ ] PIP works on iOS + Android
- [ ] Controls auto-hide after 3s
- [ ] Fullscreen works reliably

---

## Risk Assessment

| Risk | Impact | Mitigation |
|------|--------|------------|
| better_player breaking changes | High | Pin version, monitor updates |
| PIP not working on all devices | Medium | Graceful degradation |
| Stream format incompatibility | High | Test multiple stream sources |
| Memory leaks in player | High | Proper dispose() handling |

---

## Security Considerations

- Use signed URLs for protected content
- DRM integration for premium content (Widevine/FairPlay)
- Token-based stream authentication
- Prevent screen recording (optional DRM flag)

---

## Next Steps

**Depends on this phase:**
- Phase 04: Netflix UI (video previews in hero)
- Phase 05: Content Management (episode playback)
- Phase 07: Caching (video caching)
- Phase 08: Offline Downloads

---

## Unresolved Questions

1. Stream source: Test URLs or real CDN?
2. DRM requirements for MVP?
3. Skip intro/outro markers in metadata?
4. Picture-in-picture priority vs. background audio?
