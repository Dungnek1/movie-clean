# CineStream: Netflix-like Streaming Platform

**Project:** movie_clean → CineStream | **Date:** 2025-12-05 | **Status:** Planning

---

## Overview

Transform existing Clean Architecture Flutter app into full-featured Netflix-like streaming platform with authentication, video streaming (HLS/DASH), multi-profile support, and offline capabilities.

**Current Stack:** Flutter 3.10+, Riverpod 2.5.1, GoRouter 14.1.4, Dio 5.5.0

---

## Phase Summary

| Phase | Name | Priority | Status | Progress |
|-------|------|----------|--------|----------|
| 01 | [Foundation](./phase-01-foundation.md) | P0 | Planned | 0% |
| 02 | [Authentication](./phase-02-authentication.md) | P0 | Planned | 0% |
| 03 | [Video Streaming](./phase-03-video-streaming.md) | P0 | Planned | 0% |
| 04 | [Netflix UI](./phase-04-netflix-ui.md) | P0 | Planned | 0% |
| 05 | [Content Management](./phase-05-content-management.md) | P1 | Planned | 0% |
| 06 | [Search & Discovery](./phase-06-search-discovery.md) | P1 | Planned | 0% |
| 07 | [Caching & Performance](./phase-07-caching-performance.md) | P1 | Planned | 0% |
| 08 | [Advanced Features](./phase-08-advanced-features.md) | P2 | Planned | 0% |
| 09 | [Analytics & Polish](./phase-09-analytics-polish.md) | P2 | Planned | 0% |

---

## Success Metrics

**Technical:**
- Video playback latency <2s on 4G
- 60fps smooth scrolling on carousels
- <5MB APK size increase
- 95%+ crash-free sessions

**User Experience:**
- Cold start <3s
- Offline playback works after download
- Profile switching <1s
- Search results <500ms

---

## Research Documents

- [Streaming Architecture Research](./research/researcher-01-streaming-architecture.md)
- [Flutter Packages Research](./research/researcher-02-flutter-packages.md)
- [Codebase Analysis Report](./reports/01-codebase-analysis.md)

---

## Key Decisions

1. **Video Player:** better_player (HLS/DASH/DRM/PIP support)
2. **Auth:** flutter_secure_storage + custom JWT
3. **Caching:** flutter_cache_manager + cached_network_image
4. **Database:** Hive (local) + Firebase/Supabase (remote)
5. **UI:** Custom Netflix-style components, dark theme

---

## Unresolved Questions

1. Backend choice: Firebase vs Supabase vs custom API?
2. Content source: TMDB API for metadata?
3. Video CDN: AWS CloudFront vs Cloudflare?
4. DRM licensing requirements?
5. Max offline cache size per user?

---

**Generated:** 2025-12-05 | **Plan Path:** `plans/251205-1533-netflix-streaming-platform`
