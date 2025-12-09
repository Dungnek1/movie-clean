# Phase 09: Analytics & Polish

**Parent:** [plan.md](./plan.md) | **Priority:** P2 | **Status:** Planned

---

## Context

**Dependencies:** All previous phases
**Research:** [Streaming Architecture](./research/researcher-01-streaming-architecture.md)

---

## Overview

Implement analytics, error monitoring, and final UX polish for production readiness.

**Estimated Duration:** 3-4 days

---

## Key Insights

- Firebase Analytics for user behavior
- Crashlytics for error tracking
- A/B testing for UI experiments
- Performance monitoring for bottlenecks

---

## Requirements

**Functional:**
- Screen view tracking
- Playback analytics (start, pause, complete)
- Search analytics (queries, results clicked)
- Error reporting with context
- Performance metrics dashboard

**Technical:**
- Firebase Analytics integration
- Firebase Crashlytics setup
- Custom event tracking
- A/B testing framework
- Performance monitoring

---

## Architecture

### Analytics Events
```dart
AnalyticsEvent
├── screen_view(name, params)
├── content_view(contentId, type, source)
├── playback_start(contentId, position, quality)
├── playback_pause(contentId, position, duration)
├── playback_complete(contentId, watchTime)
├── search_query(query, resultCount)
├── search_result_click(contentId, position)
├── download_start(contentId, quality)
├── download_complete(contentId, size)
├── profile_switch(fromId, toId)
└── error(type, message, stackTrace)
```

### Error Categories
```
ErrorType
├── network_error     # API failures
├── playback_error    # Video issues
├── auth_error        # Login failures
├── download_error    # Download failures
└── storage_error     # Cache/storage issues
```

---

## Related Code Files

### Existing (Modify)
- All pages - Add screen tracking
- Video player - Add playback events
- Search - Add query tracking

### New Files
```
lib/src/core/
├── analytics/
│   ├── analytics_service.dart
│   ├── analytics_events.dart
│   └── analytics_provider.dart
├── monitoring/
│   ├── crash_reporter.dart
│   ├── performance_monitor.dart
│   └── error_handler.dart
└── experiments/
    ├── ab_test_service.dart
    └── feature_flags.dart

lib/src/presentation/
├── providers/
│   └── analytics_provider.dart
└── widgets/
    ├── analytics_wrapper.dart
    └── error_boundary.dart
```

---

## Implementation Steps

1. Add firebase_analytics, firebase_crashlytics, firebase_performance
2. Configure Firebase for iOS/Android/Web
3. Create AnalyticsService with event methods
4. Create CrashReporter for error handling
5. Create PerformanceMonitor for metrics
6. Create AnalyticsWrapper for automatic screen tracking
7. Add playback analytics to video player
8. Add search analytics to search provider
9. Add download analytics to download service
10. Create ErrorBoundary widget for graceful failures
11. Implement feature flags service
12. Create A/B test wrapper
13. Add final UI polish (transitions, haptics)
14. Optimize app icon and splash screen
15. Final performance audit

---

## Todo List

- [ ] Add firebase_analytics ^11.0.0
- [ ] Add firebase_crashlytics ^4.0.0
- [ ] Add firebase_performance ^0.10.0
- [ ] Configure Firebase project
- [ ] Create AnalyticsService
- [ ] Create analytics events enum
- [ ] Create CrashReporter
- [ ] Create PerformanceMonitor
- [ ] Create AnalyticsWrapper widget
- [ ] Add screen tracking to all pages
- [ ] Add playback event tracking
- [ ] Add search event tracking
- [ ] Add download event tracking
- [ ] Create ErrorBoundary widget
- [ ] Create FeatureFlagsService
- [ ] Create ABTestService
- [ ] Polish screen transitions
- [ ] Add haptic feedback
- [ ] Optimize splash screen
- [ ] Create production app icon
- [ ] Final performance audit
- [ ] Run accessibility audit
- [ ] Create release build

---

## Success Criteria

- [ ] All screen views tracked
- [ ] Playback events capture >95%
- [ ] Crash-free rate >99%
- [ ] Performance baseline established
- [ ] Error context captures stack + device
- [ ] A/B test framework functional
- [ ] Final build under 50MB

---

## Risk Assessment

| Risk | Impact | Mitigation |
|------|--------|------------|
| Analytics bloat | Medium | Batch events, rate limit |
| Privacy compliance | High | GDPR consent flow |
| Firebase quota | Low | Monitor usage dashboard |
| A/B test conflicts | Low | One test per surface |

---

## Security Considerations

- No PII in analytics events
- GDPR/CCPA consent before tracking
- Opt-out mechanism in settings
- Anonymize user IDs where possible

---

## Polish Checklist

- [ ] Smooth page transitions
- [ ] Loading states consistent
- [ ] Error messages user-friendly
- [ ] Empty states designed
- [ ] Haptic feedback on actions
- [ ] Pull-to-refresh where appropriate
- [ ] Keyboard navigation (web)
- [ ] Accessibility labels (screen readers)
- [ ] Dark mode only (Netflix style)
- [ ] App icon polished
- [ ] Splash screen branded

---

## Next Steps

**After this phase:**
- Production release
- Ongoing monitoring
- Feature iterations

---

## Unresolved Questions

1. Firebase free tier sufficient?
2. Custom analytics backend needed?
3. GDPR consent UI design?
4. A/B test first experiment scope?
