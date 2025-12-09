import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../providers/movie_providers.dart';
import '../widgets/movie_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsync = ref.watch(popularMoviesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CineStream'),
      ),
      body: moviesAsync.when(
        data: (movies) {
          if (movies.isEmpty) {
            return const Center(child: Text('Chưa có phim', style: TextStyle(color: Colors.white70)));
          }
          final featured = movies.first;
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _HeroBanner(
                  title: featured.title,
                  overview: featured.overview,
                  posterUrl: featured.posterUrl,
                  onPlay: () => context.goNamed('player', extra: {
                    'videoUrl': featured.videoUrl,
                    'title': featured.title,
                  }),
                  onMore: () => context.goNamed('movieDetail', pathParameters: {
                    'id': featured.id,
                  }),
                ),
              ),
              SliverToBoxAdapter(
                child: _HorizontalCarousel(
                  title: 'Trending',
                  movies: movies,
                  onTap: (m) => context.goNamed('movieDetail', pathParameters: {
                    'id': m.id,
                  }),
                ),
              ),
              SliverToBoxAdapter(
                child: _HorizontalCarousel(
                  title: 'Top Rated',
                  movies: List.from(movies)..sort((a, b) => b.rating.compareTo(a.rating)),
                  onTap: (m) => context.goNamed('movieDetail', pathParameters: {
                    'id': m.id,
                  }),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.54,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final movie = movies[index];
                      return MovieCard(
                        movie: movie,
                        onTap: () => context.goNamed('movieDetail', pathParameters: {
                          'id': movie.id,
                        }),
                      );
                    },
                    childCount: movies.length,
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text('Lỗi tải danh sách phim: $e', style: const TextStyle(color: Colors.white70)),
        ),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  final String title;
  final String overview;
  final String posterUrl;
  final VoidCallback onPlay;
  final VoidCallback onMore;

  const _HeroBanner({
    required this.title,
    required this.overview,
    required this.posterUrl,
    required this.onPlay,
    required this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bannerHeight = screenHeight * 0.3; // 30% of screen height (responsive)

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: posterUrl,
              height: bannerHeight,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (_, __) => Shimmer.fromColors(
                baseColor: Colors.grey.shade800,
                highlightColor: Colors.grey.shade700,
                child: Container(
                  height: bannerHeight,
                  color: Colors.grey.shade800,
                ),
              ),
              errorWidget: (_, __, ___) => Container(
                height: bannerHeight,
                color: Colors.grey.shade900,
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image, color: Colors.white54),
              ),
            ),
          ),
          Container(
            height: bannerHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black87, Colors.transparent],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  overview,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: onPlay,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Play'),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: onMore,
                      icon: const Icon(Icons.info_outline, color: Colors.white),
                      label: const Text(
                        'More info',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white54),
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
  }
}

class _HorizontalCarousel extends StatelessWidget {
  final String title;
  final List<dynamic> movies;
  final void Function(dynamic movie) onTap;

  const _HorizontalCarousel({
    required this.title,
    required this.movies,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.35; // 35% of screen width (responsive)
    final cardHeight = cardWidth * 1.5; // Maintain 2:3 aspect ratio

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('See all'),
              ),
            ],
          ),
          SizedBox(
            height: cardHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final movie = movies[index];
                return SizedBox(
                  width: cardWidth,
                  child: MovieCard(
                    movie: movie,
                    onTap: () => onTap(movie),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

