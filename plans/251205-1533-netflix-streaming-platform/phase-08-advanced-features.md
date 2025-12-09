# Phase 08: Advanced Features

**Parent:** [plan.md](./plan.md) | **Priority:** P2 | **Status:** Planned

---

## Context

**Dependencies:** Phase 02 (Profiles), Phase 03 (Video), Phase 07 (Caching)
**Research:** [Flutter Packages](./research/researcher-02-flutter-packages.md)

---

## Overview

Implement offline downloads, parental controls, and advanced profile features for complete Netflix parity.

**Estimated Duration:** 5-6 days

---

## Key Insights

- Offline: use progressive download (not HLS segments)
- Downloads: track progress, resume on network loss
- Parental controls: PIN + content rating filters
- Kids profile: restricted UI + content

---

## Requirements

**Functional:**
- Download movies/episodes for offline viewing
- Download queue management
- Auto-delete watched downloads (optional)
- Parental control PIN
- Content rating restrictions per profile
- Kids profile mode
- Viewing activity log
- Device management

**Technical:**
- Background download service
- Download state persistence
- Encryption for downloaded content (optional DRM)
- Profile-based content filtering

---

## Architecture

### Download State
```dart
DownloadState
├── queued      # Waiting to start
├── downloading # In progress (0-100%)
├── paused      # User paused
├── completed   # Ready for offline
├── failed      # Error occurred
└── expired     # License expired

Download
├── id: String
├── contentId: String
├── contentType: ContentType
├── state: DownloadState
├── progress: double (0.0-1.0)
├── totalBytes: int
├── downloadedBytes: int
├── filePath: String
├── quality: VideoQuality
├── expiresAt: DateTime?
└── createdAt: DateTime
```

### Parental Controls
```dart
ParentalSettings
├── pin: String (encrypted)
├── maxRating: ContentRating
├── restrictedGenres: List<Genre>
├── viewingTimeLimit: Duration?
├── enabled: bool
└── lockedProfiles: List<ProfileId>
```

---

## Related Code Files

### Existing (Modify)
- `lib/src/domain/entities/profile.dart` - Add kid mode, restrictions
- `lib/src/presentation/pages/downloads_page.dart` - Full implementation

### New Files
```
lib/src/domain/
├── entities/
│   ├── download.dart
│   └── parental_settings.dart
├── repositories/
│   ├── download_repository.dart
│   └── parental_repository.dart
└── usecases/
    ├── start_download.dart
    ├── pause_download.dart
    ├── delete_download.dart
    └── verify_parental_pin.dart

lib/src/data/
├── datasources/
│   └── download_local_data_source.dart
├── models/
│   ├── download_model.dart
│   └── parental_settings_model.dart
├── repositories/
│   ├── download_repository_impl.dart
│   └── parental_repository_impl.dart
└── services/
    └── download_service.dart

lib/src/presentation/
├── providers/
│   ├── download_provider.dart
│   └── parental_provider.dart
├── pages/
│   ├── downloads_page.dart       # Full redesign
│   ├── parental_settings_page.dart
│   ├── pin_entry_page.dart
│   ├── device_management_page.dart
│   └── viewing_activity_page.dart
└── widgets/
    ├── download_item.dart
    ├── download_progress.dart
    ├── quality_picker.dart
    └── pin_input.dart
```

---

## Implementation Steps

1. Add flutter_downloader ^1.11.0 or background_downloader
2. Create Download entity with all state fields
3. Create DownloadRepository interface
4. Implement DownloadLocalDataSource (Hive)
5. Create DownloadService with background capability
6. Implement download queue management
7. Create DownloadNotifier (Riverpod)
8. Create DownloadsPage with list + progress
9. Create DownloadItem widget with controls
10. Create QualityPicker for download quality
11. Create ParentalSettings entity
12. Create ParentalRepository
13. Implement PIN encryption/verification
14. Create ParentalSettingsPage
15. Create PinEntryPage
16. Implement content filtering by rating
17. Create Kids profile mode UI variant
18. Create ViewingActivityPage
19. Implement auto-delete watched downloads

---

## Todo List

- [ ] Add flutter_downloader or background_downloader
- [ ] Create Download entity
- [ ] Create DownloadRepository interface
- [ ] Create DownloadLocalDataSource
- [ ] Implement DownloadService
- [ ] Implement download queue
- [ ] Create DownloadNotifier
- [ ] Create DownloadsPage
- [ ] Create DownloadItem widget
- [ ] Create DownloadProgress widget
- [ ] Create QualityPicker widget
- [ ] Create ParentalSettings entity
- [ ] Create ParentalRepository
- [ ] Implement PIN encryption
- [ ] Create ParentalSettingsPage
- [ ] Create PinEntryPage
- [ ] Create PinInput widget
- [ ] Implement content rating filter
- [ ] Create Kids profile mode
- [ ] Create ViewingActivityPage
- [ ] Implement auto-delete option
- [ ] Test background downloads
- [ ] Test PIN verification

---

## Success Criteria

- [ ] Downloads work in background
- [ ] Resume after network loss
- [ ] Offline playback works
- [ ] Parental PIN protects settings
- [ ] Kids profile shows appropriate content
- [ ] Download progress accurate
- [ ] Auto-delete frees storage

---

## Risk Assessment

| Risk | Impact | Mitigation |
|------|--------|------------|
| Background task killed | High | Use WorkManager/BGTaskScheduler |
| Storage full | Medium | Check before download, warn user |
| PIN bypass | Medium | Secure storage + timeout lock |
| Download corruption | Medium | Checksum verification |

---

## Security Considerations

- Encrypt downloaded content
- Store PIN securely (never plaintext)
- Validate content license before playback
- Timeout parental PIN entry after 3 failures
- Log parental control changes

---

## Next Steps

**Depends on this phase:**
- Phase 09: Analytics (download tracking)

---

## Unresolved Questions

1. Download encryption: required for DRM compliance?
2. Max downloads per profile/device?
3. Download expiration: license-based or time-based?
4. Background download: WorkManager vs Isolate?
