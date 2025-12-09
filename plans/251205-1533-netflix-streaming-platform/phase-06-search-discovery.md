# Phase 06: Search & Discovery

**Parent:** [plan.md](./plan.md) | **Priority:** P1 | **Status:** Planned

---

## Context

**Dependencies:** Phase 05 (Content data)
**Research:** [Streaming Architecture](./research/researcher-01-streaming-architecture.md)

---

## Overview

Implement search, filtering, and recommendation features for content discovery.

**Estimated Duration:** 3-4 days

---

## Key Insights

- Search: debounced input, instant results, highlight matches
- Filters: genre, year, rating, content type (movie/series)
- Recommendations: based on watch history, genre preferences
- TMDB provides search + recommendations endpoints

---

## Requirements

**Functional:**
- Text search with autocomplete suggestions
- Filter by genre, year, rating, type
- Sort by popularity, rating, release date
- "Because you watched X" recommendations
- "More like this" on detail pages
- Trending searches display

**Technical:**
- Debounced search (300ms delay)
- Search result caching
- Pagination for results
- Filter state persistence

---

## Architecture

### Search Flow
```
SearchInput → Debounce(300ms) → Query API → Display Results
           → Show Recent Searches (on focus)
           → Show Trending (on empty)
```

### Filter State
```dart
ContentFilter
├── query: String?
├── genres: List<Genre>
├── yearRange: (int, int)?
├── ratingMin: double?
├── contentType: ContentType? (movie/series/all)
├── sortBy: SortOption (popularity/rating/date)
└── sortOrder: SortOrder (asc/desc)
```

### Recommendation Types
```
Recommendations
├── BecauseYouWatched    # Based on single title
├── TopPicksForYou       # Based on profile history
├── TrendingNow          # Global trending
├── NewInGenre           # New releases in favorite genres
└── MoreLikeThis         # Similar content on detail page
```

---

## Related Code Files

### Existing (Modify)
- `lib/src/presentation/pages/search_page.dart` - Full implementation

### New Files
```
lib/src/domain/
├── entities/
│   ├── search_result.dart
│   └── content_filter.dart
├── repositories/
│   └── search_repository.dart
└── usecases/
    ├── search_content.dart
    ├── get_recommendations.dart
    └── get_trending_searches.dart

lib/src/data/
├── datasources/
│   └── search_remote_data_source.dart
├── models/
│   └── search_result_model.dart
└── repositories/
    └── search_repository_impl.dart

lib/src/presentation/
├── providers/
│   ├── search_provider.dart
│   ├── filter_provider.dart
│   └── recommendation_provider.dart
├── widgets/
│   ├── search_bar.dart
│   ├── search_result_item.dart
│   ├── filter_sheet.dart
│   ├── filter_chip_row.dart
│   ├── recent_searches.dart
│   └── recommendation_row.dart
└── pages/
    └── filter_page.dart
```

---

## Implementation Steps

1. Create SearchResult entity with highlight positions
2. Create ContentFilter entity with all filter options
3. Create SearchRepository interface
4. Implement SearchRemoteDataSource (TMDB search endpoint)
5. Implement SearchRepositoryImpl with caching
6. Create SearchNotifier with debounce logic
7. Create FilterNotifier for filter state
8. Create SearchBar widget with clear/cancel
9. Create SearchResultItem with poster + info
10. Create FilterSheet (bottom sheet with options)
11. Create FilterChipRow for active filters
12. Implement RecentSearches (Hive storage)
13. Create RecommendationProvider
14. Create RecommendationRow widget
15. Integrate search into SearchPage

---

## Todo List

- [ ] Create SearchResult entity
- [ ] Create ContentFilter entity
- [ ] Create SearchRepository interface
- [ ] Create SearchRemoteDataSource
- [ ] Implement SearchRepositoryImpl
- [ ] Create SearchNotifier with debounce
- [ ] Create FilterNotifier
- [ ] Create SearchBar widget
- [ ] Create SearchResultItem widget
- [ ] Create FilterSheet bottom sheet
- [ ] Create FilterChipRow widget
- [ ] Implement recent searches storage
- [ ] Create RecommendationProvider
- [ ] Create RecommendationRow widget
- [ ] Implement SearchPage fully
- [ ] Create FilterPage (optional full page)
- [ ] Add keyboard navigation support
- [ ] Test search performance

---

## Success Criteria

- [ ] Search results in <500ms
- [ ] Debounce prevents excessive API calls
- [ ] Filters apply correctly
- [ ] Recent searches persist
- [ ] Recommendations show relevant content
- [ ] Empty state shows trending
- [ ] Results paginate smoothly

---

## Risk Assessment

| Risk | Impact | Mitigation |
|------|--------|------------|
| Slow search response | High | Cache + debounce |
| Irrelevant recommendations | Medium | Use watch history weights |
| Filter state complexity | Low | Use Riverpod family providers |

---

## Security Considerations

- Sanitize search input
- Rate limit search requests
- Don't expose profile data in search analytics

---

## Next Steps

**Depends on this phase:**
- Phase 09: Analytics (search analytics)

---

## Unresolved Questions

1. Elasticsearch integration or TMDB search only?
2. Voice search support?
3. Search history: how many items to store?
4. Personalization algorithm complexity?
