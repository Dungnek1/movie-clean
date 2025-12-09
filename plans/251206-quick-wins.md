# Quick Wins: Netflix Clone Patterns for CineStream

**Priority implementations that deliver immediate value**

---

## 1. TMDB Endpoints Configuration (15 mins)

**Create:** `lib/src/core/api/tmdb_endpoints.dart`

```dart
class TMDBEndpoints {
  static const baseUrl = 'https://api.themoviedb.org/3';
  static const imageBaseUrl = 'https://image.tmdb.org/t/p';

  // Movies
  static const popular = '/movie/popular';
  static const topRated = '/movie/top_rated';
  static const trending = '/trending/movie/week';
  static const upcoming = '/movie/upcoming';
  static const nowPlaying = '/movie/now_playing';

  // Search
  static const searchMovie = '/search/movie';
  static const searchMulti = '/search/multi';

  // Details
  static String movieDetails(int id) => '/movie/$id';
  static String movieVideos(int id) => '/movie/$id/videos';
  static String movieCredits(int id) => '/movie/$id/credits';

  // Images
  static String posterUrl(String? path, {String size = 'w500'}) =>
      path != null ? '$imageBaseUrl/$size$path' : '';

  static String backdropUrl(String? path, {String size = 'original'}) =>
      path != null ? '$imageBaseUrl/$size$path' : '';

  static String logoUrl(String? path) =>
      path != null ? '$imageBaseUrl/w200$path' : '';

  static String profileUrl(String? path) =>
      path != null ? '$imageBaseUrl/w185$path' : '';
}
```

**Update:** `lib/src/data/datasources/tmdb_movie_remote_data_source.dart`
```dart
// Replace hardcoded URLs with TMDBEndpoints constants
final response = await dio.get(
  '${TMDBEndpoints.baseUrl}${TMDBEndpoints.popular}',
  queryParameters: {'api_key': apiKey, 'page': page},
);
```

---

## 2. Enhanced Image Helper (20 mins)

**Create:** `lib/src/core/utils/image_helper.dart`

```dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../api/tmdb_endpoints.dart';

class ImageHelper {
  static Widget poster(
    String? path, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return _cachedImage(
      TMDBEndpoints.posterUrl(path),
      width: width,
      height: height,
      fit: fit,
    );
  }

  static Widget backdrop(
    String? path, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return _cachedImage(
      TMDBEndpoints.backdropUrl(path),
      width: width,
      height: height,
      fit: fit,
    );
  }

  static Widget logo(String? path) {
    return _cachedImage(
      TMDBEndpoints.logoUrl(path),
      fit: BoxFit.contain,
    );
  }

  static Widget _cachedImage(
    String url, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    if (url.isEmpty) {
      return _placeholder(width, height);
    }

    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      maxHeightDiskCache: 1000,
      maxWidthDiskCache: 700,
      placeholder: (context, url) => _shimmerPlaceholder(width, height),
      errorWidget: (context, url, error) => _errorWidget(width, height),
    );
  }

  static Widget _placeholder(double? width, double? height) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[900],
      child: Icon(Icons.movie, color: Colors.grey[700]),
    );
  }

  static Widget _shimmerPlaceholder(double? width, double? height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[900]!,
      highlightColor: Colors.grey[800]!,
      child: Container(
        width: width,
        height: height,
        color: Colors.grey[900],
      ),
    );
  }

  static Widget _errorWidget(double? width, double? height) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[900],
      child: Icon(Icons.broken_image, color: Colors.red),
    );
  }
}
```

**Usage:**
```dart
// In movie_card.dart or detail_page.dart
ImageHelper.poster(movie.posterPath, width: 140, height: 210);
ImageHelper.backdrop(movie.backdropPath);
```

---

## 3. Content Section Widget (30 mins)

**Create:** `lib/src/presentation/widgets/content_section.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/content.dart';
import 'movie_card.dart';

class ContentSection extends ConsumerWidget {
  final String title;
  final ProviderListenable<AsyncValue<List<Content>>> provider;
  final bool showRank;

  const ContentSection({
    super.key,
    required this.title,
    required this.provider,
    this.showRank = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentAsync = ref.watch(provider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),

        // Content list
        SizedBox(
          height: 210,
          child: contentAsync.when(
            data: (content) => ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: content.length,
              itemBuilder: (context, index) => MovieCard(
                content: content[index],
                width: 140,
                height: 210,
                showRank: showRank,
                rank: showRank ? index + 1 : null,
              ),
            ),
            loading: () => _buildLoading(),
            error: (error, stack) => _buildError(),
          ),
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: 5,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey[900]!,
        highlightColor: Colors.grey[800]!,
        child: Container(
          width: 140,
          height: 210,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Text(
        'Failed to load content',
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
```

---

## 4. Category Providers (25 mins)

**Create:** `lib/src/presentation/providers/category_providers.dart`

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/content.dart';
import '../../domain/entities/movie.dart';
import 'movie_providers.dart';

enum MovieCategory {
  popular,
  topRated,
  trending,
  upcoming,
  nowPlaying,
}

final moviesByCategoryProvider = FutureProvider.family<List<Movie>, MovieCategory>(
  (ref, category) async {
    final repository = ref.watch(movieRepositoryProvider);

    switch (category) {
      case MovieCategory.popular:
        return repository.getPopular();
      case MovieCategory.topRated:
        return repository.getTopRated();
      case MovieCategory.trending:
        return repository.getTrending();
      case MovieCategory.upcoming:
        return repository.getUpcoming();
      case MovieCategory.nowPlaying:
        return repository.getNowPlaying();
    }
  },
);

// Convenience providers
final popularMoviesProvider = FutureProvider<List<Movie>>(
  (ref) => ref.watch(moviesByCategoryProvider(MovieCategory.popular).future),
);

final topRatedMoviesProvider = FutureProvider<List<Movie>>(
  (ref) => ref.watch(moviesByCategoryProvider(MovieCategory.topRated).future),
);

final trendingMoviesProvider = FutureProvider<List<Movie>>(
  (ref) => ref.watch(moviesByCategoryProvider(MovieCategory.trending).future),
);

final upcomingMoviesProvider = FutureProvider<List<Movie>>(
  (ref) => ref.watch(moviesByCategoryProvider(MovieCategory.upcoming).future),
);

final nowPlayingMoviesProvider = FutureProvider<List<Movie>>(
  (ref) => ref.watch(moviesByCategoryProvider(MovieCategory.nowPlaying).future),
);
```

**Update repository interface:** `lib/src/domain/repositories/movie_repository.dart`
```dart
abstract class MovieRepository {
  Future<List<Movie>> getPopular();
  Future<List<Movie>> getTopRated();
  Future<List<Movie>> getTrending();
  Future<List<Movie>> getUpcoming();
  Future<List<Movie>> getNowPlaying();
  // ... existing methods
}
```

---

## 5. Enhanced Home Page (40 mins)

**Update:** `lib/src/presentation/pages/home_page.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/content_section.dart';
import '../widgets/hero_banner.dart';
import '../providers/category_providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.transparent,
            title: Text(
              'CineStream',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  // Navigate to search
                },
              ),
              IconButton(
                icon: Icon(Icons.person, color: Colors.white),
                onPressed: () {
                  // Navigate to profile
                },
              ),
            ],
          ),

          // Hero Banner (Featured Content)
          SliverToBoxAdapter(
            child: HeroBanner(),
          ),

          // Trending Now
          SliverToBoxAdapter(
            child: ContentSection(
              title: 'Trending Now',
              provider: trendingMoviesProvider,
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 20)),

          // Top 10 in Your Country
          SliverToBoxAdapter(
            child: ContentSection(
              title: 'Top 10 in Your Country',
              provider: topRatedMoviesProvider,
              showRank: true,
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 20)),

          // Popular Movies
          SliverToBoxAdapter(
            child: ContentSection(
              title: 'Popular Movies',
              provider: popularMoviesProvider,
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 20)),

          // Now Playing
          SliverToBoxAdapter(
            child: ContentSection(
              title: 'Now Playing',
              provider: nowPlayingMoviesProvider,
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 20)),

          // Coming Soon
          SliverToBoxAdapter(
            child: ContentSection(
              title: 'Coming Soon',
              provider: upcomingMoviesProvider,
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}
```

---

## 6. Hero Banner Widget (35 mins)

**Create:** `lib/src/presentation/widgets/hero_banner.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/image_helper.dart';
import '../providers/category_providers.dart';

class HeroBanner extends ConsumerWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendingAsync = ref.watch(trendingMoviesProvider);

    return trendingAsync.when(
      data: (movies) {
        if (movies.isEmpty) return SizedBox.shrink();

        final featuredMovie = movies.first;

        return Container(
          height: 500,
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: ImageHelper.backdrop(
                  featuredMovie.backdropPath,
                  fit: BoxFit.cover,
                ),
              ),

              // Gradient overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                        Colors.black,
                      ],
                      stops: [0.0, 0.7, 1.0],
                    ),
                  ),
                ),
              ),

              // Content
              Positioned(
                left: 16,
                right: 16,
                bottom: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      featuredMovie.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),

                    // Meta info
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        SizedBox(width: 4),
                        Text(
                          '${featuredMovie.voteAverage?.toStringAsFixed(1) ?? 'N/A'}',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(width: 16),
                        Text(
                          featuredMovie.releaseDate?.substring(0, 4) ?? '',
                          style: TextStyle(color: Colors.grey[400], fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Overview
                    Text(
                      featuredMovie.overview ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 24),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Navigate to player
                            },
                            icon: Icon(Icons.play_arrow, color: Colors.black),
                            label: Text(
                              'Play',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // Navigate to details
                            },
                            icon: Icon(Icons.info_outline, color: Colors.white),
                            label: Text(
                              'More Info',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.white),
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => _buildLoading(),
      error: (error, stack) => SizedBox.shrink(),
    );
  }

  Widget _buildLoading() {
    return Container(
      height: 500,
      color: Colors.grey[900],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
```

---

## 7. Enhanced Movie Card with Rank (25 mins)

**Update:** `lib/src/presentation/widgets/movie_card.dart`

```dart
import 'package:flutter/material.dart';
import '../../domain/entities/content.dart';
import '../../core/utils/image_helper.dart';

class MovieCard extends StatelessWidget {
  final Content content;
  final double width;
  final double height;
  final bool showRank;
  final int? rank;

  const MovieCard({
    super.key,
    required this.content,
    this.width = 140,
    this.height = 210,
    this.showRank = false,
    this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to detail page
      },
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              // Poster image
              Positioned.fill(
                child: ImageHelper.poster(
                  content.posterPath,
                  width: width,
                  height: height,
                ),
              ),

              // Gradient overlay for bottom info
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      SizedBox(width: 4),
                      Text(
                        content.voteAverage?.toStringAsFixed(1) ?? 'N/A',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Rank overlay (for Top 10)
              if (showRank && rank != null)
                Positioned(
                  left: -10,
                  bottom: -10,
                  child: Text(
                    '#$rank',
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.w900,
                      color: Colors.white.withOpacity(0.15),
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 8,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## Implementation Order

1. ✅ **TMDB Endpoints** (15 mins) - Foundation for all API calls
2. ✅ **Image Helper** (20 mins) - Centralized image handling
3. ✅ **Category Providers** (25 mins) - Data layer enhancement
4. ✅ **Movie Card Updates** (25 mins) - UI component improvement
5. ✅ **Content Section** (30 mins) - Reusable list widget
6. ✅ **Hero Banner** (35 mins) - Featured content showcase
7. ✅ **Home Page Update** (40 mins) - Bring it all together

**Total Time:** ~3 hours
**Impact:** Netflix-like home screen with categories, trending, top 10

---

## Testing Checklist

- [ ] All TMDB endpoints return data
- [ ] Images load with shimmer placeholders
- [ ] Error states display correctly
- [ ] Horizontal scrolling smooth
- [ ] Top 10 rank numbers visible
- [ ] Hero banner displays featured content
- [ ] Navigation to detail pages works
- [ ] App maintains 60fps scrolling

---

## Next Steps After Quick Wins

1. Implement search enhancements (debouncing, multi-criteria)
2. Add video player improvements (trailer support)
3. Implement pagination for infinite scroll
4. Add skeleton loading states
5. Create dedicated trending page
6. Build Top 10 detailed view
