# Phase 04: Netflix UI

**Parent:** [plan.md](./plan.md) | **Priority:** P0 | **Status:** Planned

---

## Context

**Dependencies:** Phase 01 (Theme), Phase 03 (Video for hero preview)
**Research:** [Streaming Architecture](./research/researcher-01-streaming-architecture.md)

---

## Overview

Transform UI into Netflix-style experience with hero banners, horizontal carousels, and cinematic dark theme.

**Estimated Duration:** 5-6 days

---

## Key Insights

- Hero banner: dynamic 16:9 with video preview, gradient overlay
- Carousels: GPU-accelerated smooth scrolling, lazy loading
- Thumbnail variation: different images per user (future personalization)
- Dark theme: #141414 background, #E50914 accent

---

## Requirements

**Functional:**
- Hero banner with featured content (video preview auto-play)
- Horizontal carousels (Continue Watching, Trending, Genres)
- Card hover/focus effects with info expansion
- Bottom navigation (Home, Search, Downloads, Profile)
- Responsive layout (mobile/tablet/desktop)

**Technical:**
- 60fps smooth scrolling
- Lazy load images (cached_network_image)
- Skeleton loading (shimmer)
- GPU-accelerated animations (flutter_animate)

---

## Architecture

### Screen Hierarchy
```
MainShell (with BottomNav)
├── HomeScreen
│   ├── HeroBanner
│   ├── ContentCarousel (Continue Watching)
│   ├── ContentCarousel (Trending Now)
│   ├── ContentCarousel (New Releases)
│   └── ContentCarousel (Per Genre)
├── SearchScreen
├── DownloadsScreen
└── ProfileScreen
```

### Component Design
```
HeroBanner
├── BackdropImage (16:9)
├── VideoPreview (muted, autoplay)
├── GradientOverlay
├── ContentInfo (title, description)
├── PlayButton
└── MoreInfoButton

ContentCarousel
├── CategoryTitle
├── HorizontalListView
│   └── ContentCard[]
└── PageIndicator (optional)

ContentCard
├── PosterImage
├── HoverOverlay (web/desktop)
└── MatchPercentage (optional)
```

---

## Related Code Files

### Existing (Modify)
- `lib/src/presentation/pages/home_page.dart` - Replace with new design
- `lib/src/presentation/widgets/movie_card.dart` - Enhance for Netflix style
- `lib/main.dart` - Apply theme

### New Files
```
lib/src/presentation/
├── pages/
│   ├── main_shell.dart         # Bottom nav container
│   ├── search_page.dart        # Search screen placeholder
│   ├── downloads_page.dart     # Downloads screen placeholder
│   └── profile_page.dart       # Profile screen placeholder
├── widgets/
│   ├── hero_banner.dart        # Featured content banner
│   ├── video_preview.dart      # Muted autoplay preview
│   ├── content_carousel.dart   # Horizontal scrolling list
│   ├── content_card.dart       # Enhanced card widget
│   ├── shimmer_loading.dart    # Skeleton loaders
│   ├── gradient_overlay.dart   # Reusable gradient
│   └── category_title.dart     # Row title with "See All"
└── providers/
    └── home_provider.dart      # Home screen state
```

---

## Implementation Steps

1. Add shimmer ^3.0.0, flutter_animate ^4.5.0, cached_network_image ^3.3.0
2. Create MainShell with BottomNavigationBar + IndexedStack
3. Update GoRouter for shell navigation
4. Create HeroBanner widget with gradient overlay
5. Create VideoPreview for muted autoplay (uses better_player)
6. Create ContentCarousel with horizontal ListView
7. Create ContentCard with poster, hover effects
8. Create ShimmerLoading for skeleton states
9. Create CategoryTitle with "See All" action
10. Refactor HomePage to use new components
11. Implement lazy loading for carousel images
12. Add scroll-based hero parallax effect
13. Create responsive breakpoints (mobile/tablet/desktop)
14. Add page transitions with flutter_animate
15. Test scrolling performance

---

## Todo List

- [ ] Add shimmer ^3.0.0
- [ ] Add flutter_animate ^4.5.0
- [ ] Add cached_network_image ^3.3.0
- [ ] Create MainShell with BottomNav
- [ ] Update GoRouter for shell routes
- [ ] Create HeroBanner widget
- [ ] Create VideoPreview component
- [ ] Create GradientOverlay widget
- [ ] Create ContentCarousel widget
- [ ] Create ContentCard widget
- [ ] Create ShimmerLoading widget
- [ ] Create CategoryTitle widget
- [ ] Refactor HomePage layout
- [ ] Implement carousel lazy loading
- [ ] Add hero parallax scroll effect
- [ ] Create responsive breakpoints
- [ ] Add page transitions
- [ ] Optimize scroll performance
- [ ] Create search page placeholder
- [ ] Create downloads page placeholder
- [ ] Create profile page placeholder

---

## Success Criteria

- [ ] 60fps scrolling on mid-range devices
- [ ] Hero banner plays video preview
- [ ] Images load with shimmer placeholders
- [ ] Carousels scroll smoothly
- [ ] Bottom nav switches screens instantly
- [ ] Dark theme consistent throughout
- [ ] Responsive on phone/tablet

---

## Risk Assessment

| Risk | Impact | Mitigation |
|------|--------|------------|
| Scroll jank | High | Profile with DevTools, optimize rebuilds |
| Hero video memory | Medium | Pause video when scrolled away |
| Image cache bloat | Medium | Set max cache size |
| Responsive complexity | Medium | Start mobile-first |

---

## Security Considerations

- Cache images with expiration
- Sanitize content descriptions (XSS prevention)
- Rate limit hero content API

---

## Next Steps

**Depends on this phase:**
- Phase 05: Content Management (carousel data)
- Phase 06: Search & Discovery (search UI)

---

## Unresolved Questions

1. Hero banner rotation interval?
2. Carousel item count before "See All"?
3. Enable video preview sound on tap?
4. Card aspect ratio: 2:3 (poster) or 16:9 (thumbnail)?
