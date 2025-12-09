# Phase 07: Caching & Performance

**Parent:** [plan.md](./plan.md) | **Priority:** P1 | **Status:** Planned

---

## Context

**Dependencies:** Phase 04 (Images), Phase 05 (Content data)
**Research:** [Streaming Architecture](./research/researcher-01-streaming-architecture.md), [Flutter Packages](./research/researcher-02-flutter-packages.md)

---

## Overview

Implement multi-tier caching for images, API responses, and video segments. Optimize performance for smooth 60fps experience.

**Estimated Duration:** 3-4 days

---

## Key Insights

- Image caching: cached_network_image (memory + disk)
- API caching: dio_cache_interceptor (stale-while-revalidate)
- Video caching: cached_video_player_plus (segment-based)
- HLS streams NOT fully cacheable; use progressive downloads for offline

---

## Requirements

**Functional:**
- Images load instantly on revisit
- Content lists load from cache when offline
- Video segments buffer ahead
- Clear cache option in settings

**Technical:**
- Multi-tier cache (memory → disk → network)
- Stale-while-revalidate strategy
- Max cache size limits
- Cache expiration policies

---

## Architecture

### Cache Layers
```
Request Flow:
1. Memory Cache (LRU, 50MB) → fastest
2. Disk Cache (Hive/Files, 500MB) → persistent
3. Network Request → fresh data
4. Update caches with new data
```

### Cache Configuration
```dart
CacheConfig
├── imageCache
│   ├── maxMemory: 50MB
│   ├── maxDisk: 200MB
│   └── stalePeriod: 7 days
├── apiCache
│   ├── maxDisk: 50MB
│   ├── stalePeriod: 1 hour
│   └── staleWhileRevalidate: true
└── videoCache
    ├── maxDisk: 500MB
    ├── segmentsAhead: 3
    └── clearOnLowStorage: true
```

### Performance Targets
```
Metrics:
├── Cold Start: <3s
├── Image Load: <200ms (cached)
├── API Response: <300ms (cached)
├── Scroll FPS: 60fps sustained
├── Memory: <150MB peak
└── APK Size: <50MB
```

---

## Related Code Files

### Existing (Modify)
- `lib/main.dart` - Initialize cache managers
- Dio instance - Add cache interceptor

### New Files
```
lib/src/core/
├── cache/
│   ├── cache_config.dart
│   ├── image_cache_manager.dart
│   ├── api_cache_manager.dart
│   └── video_cache_manager.dart
├── interceptors/
│   └── cache_interceptor.dart
└── utils/
    ├── performance_monitor.dart
    └── memory_manager.dart

lib/src/presentation/
├── widgets/
│   └── optimized_image.dart
└── pages/
    └── settings/
        └── cache_settings_page.dart
```

---

## Implementation Steps

1. Add flutter_cache_manager ^3.3.0, dio_cache_interceptor ^3.5.0
2. Configure CachedNetworkImage global settings
3. Create ApiCacheManager with disk storage
4. Add CacheInterceptor to Dio instance
5. Configure stale-while-revalidate policy
6. Create VideoCacheManager for video segments
7. Implement OptimizedImage widget with fade-in
8. Add performance monitoring (DevTools integration)
9. Create MemoryManager for low-memory handling
10. Implement cache clear functionality
11. Create CacheSettingsPage in settings
12. Add cache size display in settings
13. Optimize ListView with cacheExtent
14. Add const constructors where possible
15. Profile and fix jank issues

---

## Todo List

- [ ] Add flutter_cache_manager ^3.3.0
- [ ] Add dio_cache_interceptor ^3.5.0
- [ ] Configure CachedNetworkImage defaults
- [ ] Create CacheConfig constants
- [ ] Create ApiCacheManager
- [ ] Create CacheInterceptor for Dio
- [ ] Configure stale-while-revalidate
- [ ] Create VideoCacheManager
- [ ] Create OptimizedImage widget
- [ ] Implement performance monitoring
- [ ] Create MemoryManager
- [ ] Implement cache clear function
- [ ] Create CacheSettingsPage
- [ ] Display cache size in settings
- [ ] Optimize ListViews with cacheExtent
- [ ] Add const constructors audit
- [ ] Profile with Flutter DevTools
- [ ] Fix identified jank issues
- [ ] Test offline behavior

---

## Success Criteria

- [ ] Images load <200ms from cache
- [ ] API responses <300ms from cache
- [ ] 60fps scroll performance
- [ ] Offline mode shows cached content
- [ ] Cache respects size limits
- [ ] Clear cache works correctly
- [ ] Memory stays <150MB

---

## Risk Assessment

| Risk | Impact | Mitigation |
|------|--------|------------|
| Cache corruption | Medium | Validation + fallback to network |
| Storage overflow | Medium | Auto-eviction, size limits |
| Memory pressure | High | LRU eviction, dispose properly |
| Stale data issues | Low | TTL + manual refresh option |

---

## Security Considerations

- Encrypt sensitive cached data
- Clear auth tokens on logout
- Don't cache payment info
- Validate cached data integrity

---

## Next Steps

**Depends on this phase:**
- Phase 08: Offline Downloads (extends caching)

---

## Unresolved Questions

1. Max cache size per device tier?
2. Auto-clear on low storage threshold?
3. Prefetch strategy for carousels?
4. Service worker caching for web?
