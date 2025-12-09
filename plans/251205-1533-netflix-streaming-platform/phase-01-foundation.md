# Phase 01: Foundation

**Parent:** [plan.md](./plan.md) | **Priority:** P0 | **Status:** Planned

---

## Context

**Dependencies:** None (first phase)
**Research:** [Codebase Analysis](./reports/01-codebase-analysis.md), [Flutter Packages](./research/researcher-02-flutter-packages.md)

---

## Overview

Expand core entities, repositories, and theme system. Add essential packages and establish patterns for streaming platform.

**Estimated Duration:** 3-4 days

---

## Key Insights

- Current app has basic Movie entity; need Series, Episode, User, Profile, Genre
- Clean Architecture already in place; extend without breaking patterns
- Riverpod 2.5.1 supports StateNotifier and AsyncNotifier (use latter for new features)

---

## Requirements

**Functional:**
- Extended content entities (Movie, Series, Episode, Genre)
- User/Profile entities for multi-profile support
- Dark theme matching Netflix aesthetics
- Package infrastructure for video/auth/caching

**Technical:**
- Maintain Clean Architecture layers
- Use freezed for immutable entities
- Configure theme with custom color palette

---

## Architecture

### Entity Hierarchy
```
Content (abstract)
├── Movie
│   ├── id, title, overview, posterUrl, backdropUrl
│   ├── rating, releaseDate, duration, genres
│   └── videoUrl, trailerUrl
└── Series
    ├── id, title, overview, posterUrl, backdropUrl
    ├── rating, releaseDate, genres, seasonCount
    └── seasons: List<Season>
        └── episodes: List<Episode>

User
├── id, email, name, createdAt
└── profiles: List<Profile>
    ├── id, name, avatarUrl, isKid
    └── preferences, watchHistory
```

### Theme Structure
```
AppTheme
├── colors: AppColors (primary, secondary, background, surface, text)
├── typography: AppTypography (headline, body, caption)
└── spacing: AppSpacing (xs, sm, md, lg, xl)
```

---

## Related Code Files

### Existing (Modify)
- `lib/src/domain/entities/movie.dart` - Expand Movie entity
- `lib/pubspec.yaml` - Add new dependencies

### New Files
```
lib/src/domain/entities/
├── content.dart          # Abstract base class
├── series.dart           # Series entity
├── episode.dart          # Episode entity
├── season.dart           # Season entity
├── genre.dart            # Genre entity
├── user.dart             # User entity
└── profile.dart          # Profile entity

lib/src/core/
├── theme/
│   ├── app_theme.dart    # Theme configuration
│   ├── app_colors.dart   # Color palette
│   └── app_typography.dart
└── constants/
    └── app_constants.dart
```

---

## Implementation Steps

1. Add freezed, json_annotation, build_runner to pubspec.yaml
2. Create abstract Content base class with shared properties
3. Extend Movie entity with backdropUrl, videoUrl, trailerUrl, genres
4. Create Series, Season, Episode entities with parent-child relations
5. Create Genre entity with id, name, imageUrl
6. Create User and Profile entities
7. Create AppTheme with Netflix dark color palette
8. Configure ThemeData in main.dart
9. Run build_runner to generate freezed code
10. Update existing MovieModel to match new Movie entity

---

## Todo List

- [ ] Add dependencies: freezed, json_annotation, build_runner, flutter_animate, shimmer, cached_network_image
- [ ] Create Content abstract class
- [ ] Extend Movie entity with streaming fields
- [ ] Create Series entity
- [ ] Create Season entity
- [ ] Create Episode entity
- [ ] Create Genre entity
- [ ] Create User entity
- [ ] Create Profile entity
- [ ] Create AppColors with Netflix palette
- [ ] Create AppTypography
- [ ] Create AppTheme combining colors + typography
- [ ] Update main.dart to use AppTheme
- [ ] Run build_runner generate
- [ ] Update MovieModel for new fields

---

## Success Criteria

- [ ] All entities compile without errors
- [ ] Freezed generates copyWith/toJson/fromJson
- [ ] Dark theme applied consistently
- [ ] No breaking changes to existing features
- [ ] Unit tests pass for entity serialization

---

## Risk Assessment

| Risk | Impact | Mitigation |
|------|--------|------------|
| Freezed code gen issues | Medium | Use stable 2.x version |
| Theme inconsistency | Low | Create design tokens first |
| Entity relationship complexity | Medium | Start simple, extend later |

---

## Security Considerations

- User entity: never expose password hash in model
- Profile entity: prepare for parental control flags
- Sensitive data: mark fields for secure storage later

---

## Next Steps

**Depends on this phase:**
- Phase 02: Authentication (needs User/Profile entities)
- Phase 03: Video Streaming (needs Content entities)
- Phase 04: Netflix UI (needs theme system)

---

## Unresolved Questions

1. Use freezed vs manual immutability?
2. Include all TMDB fields or minimal set?
3. Netflix red (#E50914) or custom brand color?
