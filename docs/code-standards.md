# CineStream Code Standards & Guidelines

**Last Updated:** 2025-12-09
**Framework:** Flutter/Dart
**Architecture:** Clean Architecture with Riverpod

---

## File Organization

### Directory Structure Rules

**Layer Organization:**
```
lib/src/
├── core/        # Shared utilities (zero domain dependencies)
├── domain/      # Business logic (framework-agnostic)
├── data/        # Data access (domain implementations)
└── presentation # UI layer (depends on domain/data)
```

**Naming Convention:**
- Directories: `snake_case` (lowercase with underscores)
- Files: `snake_case.dart`
- Classes: `PascalCase`
- Functions/variables: `camelCase`
- Constants: `CONSTANT_CASE` (private constants) or `constantCase` (public constants)

### File Patterns

**Domain Layer Files:**
```
entities/
  ├── movie.dart          # @freezed entity with JSON serialization
  ├── series.dart
  └── genre.dart

repositories/
  ├── movie_repository.dart        # Abstract interface (no implementation)
  └── search_repository.dart
```

**Data Layer Files:**
```
datasources/
  ├── movie_remote_data_source.dart             # Abstract interface
  └── tmdb_movie_remote_data_source.dart        # Implementation

models/
  └── movie_model.dart            # Serializable model (extends domain entity)

repositories/
  ├── movie_repository_impl.dart   # Implements domain repository
  └── search_repository_impl.dart
```

**Presentation Layer Files:**
```
pages/
  ├── home_page.dart              # Full-screen StatefulWidget
  ├── search_page.dart
  └── detail_page.dart

widgets/
  ├── movie_card.dart             # Reusable StatelessWidget
  └── custom_app_bar.dart

providers/
  ├── movie_providers.dart         # Riverpod state management
  └── search_provider.dart

router/
  └── app_router.dart             # GoRouter configuration
```

---

## Naming Conventions

### Classes & Types
```dart
// ✅ Good: PascalCase for all classes
class MovieDetailPage extends StatefulWidget {}
class MovieCard extends StatelessWidget {}
class MovieRepository {}
typedef MovieCallback = void Function(Movie movie);

// ❌ Bad: lowercase or snake_case
class movie_card {}
class movieRepository {}
```

### Variables & Functions
```dart
// ✅ Good: camelCase with descriptive names
String movieTitle = "Inception";
void onMovieTap(Movie movie) { }
List<Movie> getPopularMovies() { }

// ❌ Bad: unclear or inconsistent
String m = "Inception";
void onTap() { }
List<Movie> getMovies() { }  // what type of movies?
```

### Constants
```dart
// ✅ Good: camelCase for public, CONSTANT_CASE for private
const String appName = 'CineStream';
const int _maxRetries = 3;

// ❌ Bad: inconsistent case
const String APP_NAME = 'CineStream';
const String appName_v2 = 'CineStream';
```

### Private Members
```dart
// ✅ Good: leading underscore for private
class _MovieListState extends State<MovieList> {
  String _query = '';
  void _onSearchChanged(String value) { }
}

// ❌ Bad: no underscore
class MovieListState extends State<MovieList> {
  String query = '';
  void onSearchChanged(String value) { }
}
```

### Provider Naming
```dart
// ✅ Good: descriptive provider names with types
final movieProvider = FutureProvider<List<Movie>>((ref) => ...);
final searchQueryProvider = StateProvider<String>((ref) => '');
final selectedMovieProvider = StateProvider<Movie?>((ref) => null);

// ❌ Bad: vague or incomplete names
final movies = FutureProvider((ref) => ...);
final search = StateProvider((ref) => '');
```

---

## Dart Coding Standards

### Imports Organization
```dart
// ✅ Good: organized and sorted
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/movie.dart';
import '../widgets/movie_card.dart';

// ❌ Bad: random order, mixed groups
import 'package:flutter/material.dart';
import '../../domain/entities/movie.dart';
import 'dart:async';
import '../widgets/movie_card.dart';
```

### Type Safety & Null Safety
```dart
// ✅ Good: explicit types, proper null handling
String getMovieTitle(Movie? movie) {
  return movie?.title ?? 'Unknown';
}

List<Movie> filterMovies(List<Movie> movies, String query) {
  return movies.where((m) => m.title.contains(query)).toList();
}

// ❌ Bad: implicit types, nullable without handling
getMovieTitle(movie) {
  return movie.title;  // NPE if movie is null
}

filterMovies(movies, query) {  // unclear types
  return movies.where((m) => m.title.contains(query)).toList();
}
```

### Function Documentation
```dart
// ✅ Good: clear documentation with examples
/// Searches for movies matching the given query.
///
/// Returns a list of [Movie] objects where title contains [query].
/// Returns empty list if no matches found.
///
/// Example:
/// ```dart
/// final results = await searchRepository.searchMovies('Inception');
/// ```
Future<List<Movie>> searchMovies(String query) async {
  // implementation
}

// ❌ Bad: no documentation
Future<List<Movie>> search(String q) async {
  // implementation
}
```

### Const Constructors
```dart
// ✅ Good: const where possible (performant)
const MovieCard(movie: movie, onTap: onTap);
const AppBar(title: 'Home');

// ❌ Bad: unnecessary object creation
MovieCard(movie: movie, onTap: onTap);  // creates new instance each build
AppBar(title: 'Home');
```

### Error Handling
```dart
// ✅ Good: explicit error handling
try {
  final movies = await movieRepository.getMovies();
  setState(() => _movies = movies);
} on SocketException catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Network error: ${e.message}')),
  );
} catch (e) {
  debugPrint('Unexpected error: $e');
}

// ❌ Bad: silent failures or generic catch
try {
  _movies = await movieRepository.getMovies();
} catch (e) {
  // ignore error, let UI hang
}
```

---

## Flutter Widget Standards

### Widget Structure
```dart
// ✅ Good: clear separation of concerns
class MovieCard extends StatelessWidget {
  const MovieCard({
    required this.movie,
    required this.onTap,
  });

  final Movie movie;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _buildCard(),
    );
  }

  Widget _buildCard() {
    return Container(
      // card implementation
    );
  }
}

// ❌ Bad: single large build method
class MovieCard extends StatelessWidget {
  // 200+ lines in build()
}
```

### StatefulWidget Pattern
```dart
// ✅ Good: proper state management
class SearchPage extends StatefulWidget {
  const SearchPage();

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // implementation
  }
}

// ❌ Bad: incorrect state lifecycle
class SearchPage extends StatefulWidget {
  // initState in widget, not state
}
```

### Layout Best Practices
```dart
// ✅ Good: responsive and semantic
Scaffold(
  appBar: AppBar(title: const Text('Movies')),
  body: Padding(
    padding: EdgeInsets.all(Spacing.md),  // Use spacing tokens
    child: ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) => MovieCard(
        movie: movies[index],
        onTap: () => _onMovieTap(movies[index]),
      ),
    ),
  ),
)

// ❌ Bad: magic numbers and poor structure
Scaffold(
  body: Container(
    padding: const EdgeInsets.all(16),  // magic number
    child: ListView.builder(
      itemCount: movies.length,
      itemBuilder: (_, i) => MovieCard(movie: movies[i]),
    ),
  ),
)
```

---

## Riverpod State Management Standards

### Provider Declaration
```dart
// ✅ Good: explicit types, clear scope
final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  return MovieRepositoryImpl(datasource: TMDBDataSource());
});

final movieListProvider = FutureProvider<List<Movie>>((ref) {
  return ref.watch(movieRepositoryProvider).getPopularMovies();
});

final searchQueryProvider = StateProvider<String>((ref) => '');

// ❌ Bad: implicit types, unclear scope
final movieRepository = Provider((ref) {
  return MovieRepositoryImpl(datasource: TMDBDataSource());
});

final movies = FutureProvider((ref) => ...);  // unclear what movies
```

### Provider Usage in Widgets
```dart
// ✅ Good: proper async handling
class HomePage extends ConsumerWidget {
  const HomePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsync = ref.watch(movieListProvider);

    return moviesAsync.when(
      data: (movies) => MovieGrid(movies: movies),
      loading: () => const ShimmerLoading(),
      error: (err, stack) => ErrorWidget(error: err),
    );
  }
}

// ❌ Bad: ignoring loading/error states
class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(movieListProvider).asData?.value ?? [];
    return MovieGrid(movies: movies);  // crashes if loading
  }
}
```

### Provider Invalidation
```dart
// ✅ Good: selective invalidation
ref.refresh(movieListProvider);  // Refresh specific provider
ref.invalidate(searchQueryProvider);

// ❌ Bad: invalidating everything
ref.invalidateAll();  // Kills entire app state
```

---

## Design System Usage

### Color Palette Rules
```dart
// ✅ Good: semantic colors from AppColors
Container(
  color: AppColors.surface,
  child: Text('Hello', style: TextStyle(color: AppColors.textPrimary)),
)

// ❌ Bad: hardcoded colors
Container(
  color: Color(0xFF141414),
  child: Text('Hello', style: const TextStyle(color: Colors.white)),
)
```

### Typography Rules
```dart
// ✅ Good: use AppTypography scale
Text('Movie Title', style: AppTypography.headlineMedium);
Text('Description', style: AppTypography.bodyMedium);
Text('Caption', style: AppTypography.caption);

// ❌ Bad: hardcoded sizes and inconsistent
Text('Movie Title', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
Text('Description', style: TextStyle(fontSize: 14));
Text('Caption', style: const TextStyle(fontSize: 10));
```

### Spacing Rules
```dart
// ✅ Good: use Spacing tokens
Padding(
  padding: const EdgeInsets.all(Spacing.md),
  child: Column(
    children: [
      SizedBox(height: Spacing.lg),
      MovieCard(movie: movie),
    ],
  ),
)

// ❌ Bad: magic numbers
Padding(
  padding: const EdgeInsets.all(16),
  child: Column(
    children: [
      SizedBox(height: 24),
      MovieCard(movie: movie),
    ],
  ),
)
```

### Border Radius Rules
```dart
// ✅ Good: use BorderRadii tokens
ClipRRect(
  borderRadius: BorderRadius.circular(BorderRadii.card),
  child: Image.network(posterUrl),
)

// ❌ Bad: hardcoded radius
ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: Image.network(posterUrl),
)
```

---

## Entity & Model Standards

### Freezed Class Pattern
```dart
// ✅ Good: complete freezed implementation
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    required String id,
    required String title,
    required String posterUrl,
    @Default(0.0) double rating,
    @Default('') String synopsis,
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}

// ❌ Bad: manual implementation
class Movie {
  final String id;
  final String title;

  Movie({required this.id, required this.title});
  // no immutability, no equality, no JSON support
}
```

### Model Inheritance Pattern
```dart
// ✅ Good: model extends entity
@freezed
class MovieModel extends Movie with _$MovieModel {
  const factory MovieModel({
    required String id,
    required String title,
    // ... other fields
  }) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
    _$MovieModelFromJson(json);
}

// ❌ Bad: duplicate entity definition
class MovieModel {
  final String id;
  final String title;
  // redundant fields
}
```

---

## Testing Standards

### Unit Test Structure
```dart
// ✅ Good: clear arrangement and assertions
void main() {
  group('MovieRepository', () {
    test('getPopularMovies returns movies list', () async {
      // Arrange
      final mockDataSource = MockMovieRemoteDataSource();
      final repository = MovieRepositoryImpl(datasource: mockDataSource);

      // Act
      final result = await repository.getPopularMovies();

      // Assert
      expect(result, isA<List<Movie>>());
      expect(result.length, greaterThan(0));
      verify(mockDataSource.getPopularMovies()).called(1);
    });
  });
}

// ❌ Bad: unclear test structure
void main() {
  test('movies work', () async {
    var r = MovieRepositoryImpl(datasource: m);
    var result = await r.getPopularMovies();
    expect(result.length, 5);  // magic number
  });
}
```

### Widget Test Pattern
```dart
// ✅ Good: proper test setup
void main() {
  testWidgets('MovieCard displays title', (WidgetTester tester) async {
    final movie = Movie(
      id: '1',
      title: 'Inception',
      posterUrl: 'https://...',
      rating: 8.8,
      synopsis: 'A thief...',
      genres: [],
      releaseYear: 2010,
    );

    await tester.pumpWidget(
      MaterialApp(home: MovieCard(movie: movie, onTap: () {})),
    );

    expect(find.text('Inception'), findsOneWidget);
  });
}
```

---

## Performance Guidelines

### Image Optimization
```dart
// ✅ Good: optimized image loading
CachedNetworkImage(
  imageUrl: movie.posterUrl,
  placeholder: (context, url) => const ShimmerLoading(),
  errorWidget: (context, url, error) => const PlaceholderImage(),
  cacheManager: cacheManager,
  fit: BoxFit.cover,
)

// ❌ Bad: unoptimized image
Image.network(
  movie.posterUrl,
  // no caching, no placeholder, no error handling
)
```

### List Performance
```dart
// ✅ Good: efficient list building
ListView.builder(
  itemCount: movies.length,
  itemBuilder: (context, index) => MovieCard(movie: movies[index]),
)

// ❌ Bad: creates all items at once
ListView(
  children: movies.map((m) => MovieCard(movie: m)).toList(),
)
```

### Debouncing Example
```dart
// ✅ Good: debounced search
class SearchPageState extends State<SearchPage> {
  Timer? _debounce;

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() => _query = value);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}

// ❌ Bad: uncontrolled API calls
void _onSearchChanged(String value) {
  setState(() => _query = value);  // fires on every keystroke
}
```

---

## Code Review Checklist

### Before Submitting Code
- [ ] Follows file organization and naming conventions
- [ ] All widgets use design tokens (colors, typography, spacing)
- [ ] Null safety properly handled (no force unwraps)
- [ ] Async operations show loading/error states
- [ ] Error handling implemented (try-catch, error dialogs)
- [ ] Proper use of const constructors
- [ ] No hardcoded values (use theme/spacing tokens)
- [ ] Functions are documented with /// comments
- [ ] Imports organized and sorted
- [ ] No commented-out code (delete unused code)
- [ ] Tests written for new functionality
- [ ] No console.log style debug statements (use debugPrint)

---

## Documentation Requirements

### Inline Comments
```dart
// ✅ Good: explains "why", not "what"
// Debounce search to reduce API calls during rapid typing
_debounce?.cancel();
_debounce = Timer(const Duration(milliseconds: 300), () { ... });

// ❌ Bad: obvious comments
// Set _query to value
setState(() => _query = value);
```

### Public API Documentation
```dart
/// Searches for movies matching the given [query].
///
/// Returns empty list if no matches found. Uses 300ms debounce
/// to optimize API calls during typing.
///
/// Example:
/// ```dart
/// final movies = await searchRepository.search('Inception');
/// ```
Future<List<Movie>> search(String query) async { }
```

---

## Common Anti-patterns to Avoid

1. **BuildContext in Providers** - Don't pass context to providers
2. **Synchronous blocking** - Always use async/await for I/O
3. **Magic Numbers** - Use constants or theme tokens
4. **Global Variables** - Use Riverpod providers instead
5. **God Objects** - Keep classes focused and small
6. **Silent Failures** - Always handle and log errors
7. **Tight Coupling** - Use dependency injection via providers
8. **Missing Cleanup** - Always dispose controllers and timers

