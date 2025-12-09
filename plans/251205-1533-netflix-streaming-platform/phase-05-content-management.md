# Phase 05: Content Management

**Parent:** [plan.md](./plan.md) | **Priority:** P1 | **Status:** Planned

---

## Context

**Dependencies:** Phase 01 (Entities), Phase 04 (UI components)
**Research:** [Streaming Architecture](./research/researcher-01-streaming-architecture.md)

---

## Overview

Implement content data layer for movies, series, episodes with categories, genres, and watch progress tracking.

**Estimated Duration:** 4-5 days

---

## Key Insights

- TMDB API for metadata (free tier, 40 req/10s)
- Hierarchy: Series → Seasons → Episodes
- Watch progress per profile (not per user)
- Categories ranked by relevance + personalization

---

## Requirements

**Functional:**
- Fetch movies with full metadata
- Fetch series with seasons + episodes
- Genre-based categorization
- Continue Watching (per profile)
- Watch History (per profile)
- My List / Watchlist (per profile)

**Technical:**
- TMDB API integration
- Repository pattern for all content types
- Pagination for lists
- Local cache for quick loads

---

## Architecture

### Data Flow
```
UI → Provider → UseCase → Repository → DataSource
                                     ├── Remote (TMDB API)
                                     └── Local (Hive cache)
```

### Content Categories
```
Categories
├── Continue Watching  # Profile-specific, partial watch
├── Trending Now       # TMDB trending endpoint
├── New Releases       # Last 30 days
├── Top Rated          # Rating > 8.0
├── My List            # User-saved content
└── By Genre           # Action, Comedy, Drama, etc.
```

### Watch Progress Model
```dart
WatchProgress
├── profileId: String
├── contentId: String
├── contentType: ContentType (movie/episode)
├── position: Duration
├── duration: Duration
├── completed: bool (>90% watched)
├── watchedAt: DateTime
└── parentSeriesId: String? (for episodes)
```

---

## Related Code Files

### Existing (Modify)
- `lib/src/data/datasources/movie_remote_data_source.dart` - Add TMDB
- `lib/src/data/repositories/movie_repository_impl.dart` - Add caching

### New Files
```
lib/src/domain/
├── entities/
│   ├── watch_progress.dart
│   └── content_category.dart
├── repositories/
│   ├── series_repository.dart
│   ├── episode_repository.dart
│   ├── genre_repository.dart
│   └── watch_progress_repository.dart
└── usecases/
    ├── get_trending_content.dart
    ├── get_content_by_genre.dart
    ├── get_continue_watching.dart
    └── update_watch_progress.dart

lib/src/data/
├── datasources/
│   ├── tmdb_remote_data_source.dart
│   ├── content_local_data_source.dart
│   └── watch_progress_local_data_source.dart
├── models/
│   ├── series_model.dart
│   ├── season_model.dart
│   ├── episode_model.dart
│   ├── genre_model.dart
│   └── watch_progress_model.dart
└── repositories/
    ├── series_repository_impl.dart
    ├── genre_repository_impl.dart
    └── watch_progress_repository_impl.dart

lib/src/presentation/
├── providers/
│   ├── content_providers.dart
│   ├── watch_progress_provider.dart
│   └── watchlist_provider.dart
└── pages/
    ├── series_detail_page.dart
    └── season_episodes_page.dart
```

---

## Implementation Steps

1. Create TMDB API service with dio + rate limiting
2. Create TmdbRemoteDataSource with movie/series/genre endpoints
3. Create SeriesModel, SeasonModel, EpisodeModel
4. Create GenreModel with icon mapping
5. Implement SeriesRepository with cache layer
6. Implement GenreRepository
7. Create WatchProgress entity and model
8. Create WatchProgressRepository (Hive storage)
9. Create UseCases: GetTrendingContent, GetContentByGenre
10. Create ContentProviders for UI consumption
11. Create SeriesDetailPage showing seasons
12. Create SeasonEpisodesPage with episode list
13. Implement Continue Watching logic
14. Implement My List (watchlist) add/remove
15. Add pagination to content lists

---

## Todo List

- [ ] Create TMDB API key config
- [ ] Create TmdbRemoteDataSource
- [ ] Create SeriesModel + fromJson
- [ ] Create SeasonModel + fromJson
- [ ] Create EpisodeModel + fromJson
- [ ] Create GenreModel + fromJson
- [ ] Implement SeriesRepositoryImpl
- [ ] Implement GenreRepositoryImpl
- [ ] Create ContentLocalDataSource (Hive)
- [ ] Create WatchProgress entity
- [ ] Create WatchProgressModel
- [ ] Implement WatchProgressRepository
- [ ] Create GetTrendingContent usecase
- [ ] Create GetContentByGenre usecase
- [ ] Create GetContinueWatching usecase
- [ ] Create content providers
- [ ] Create SeriesDetailPage
- [ ] Create SeasonEpisodesPage
- [ ] Implement My List functionality
- [ ] Add pagination support
- [ ] Test TMDB API integration

---

## Success Criteria

- [ ] Movies fetch from TMDB successfully
- [ ] Series with seasons/episodes display correctly
- [ ] Genres load with proper categorization
- [ ] Continue Watching shows per-profile progress
- [ ] My List add/remove works
- [ ] Pagination loads more content
- [ ] Cache reduces API calls

---

## Risk Assessment

| Risk | Impact | Mitigation |
|------|--------|------------|
| TMDB rate limits | Medium | Implement request queue, caching |
| API key exposure | High | Use env vars, proxy in production |
| Data model changes | Medium | Version local cache schema |
| Sync conflicts | Low | Last-write-wins strategy |

---

## Security Considerations

- Hide TMDB API key (don't commit to repo)
- Validate all API responses
- Sanitize content descriptions
- Profile ID validation for watch progress

---

## Next Steps

**Depends on this phase:**
- Phase 06: Search & Discovery (search content)
- Phase 07: Caching (cache content data)

---

## Unresolved Questions

1. TMDB API key management: env var vs secure backend?
2. Video URLs: TMDB has trailers only; streaming CDN needed?
3. Sync watch progress to backend or local only?
4. Content freshness: cache TTL duration?
