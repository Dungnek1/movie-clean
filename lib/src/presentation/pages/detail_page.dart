import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../providers/movie_providers.dart';

class DetailPage extends ConsumerWidget {
  final String movieId;

  const DetailPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieAsync = ref.watch(movieDetailProvider(movieId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết phim'),
      ),
      body: movieAsync.when(
        data: (movie) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 2 / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: movie.posterUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade800,
                      highlightColor: Colors.grey.shade700,
                      child: Container(color: Colors.grey.shade800),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: Colors.grey.shade900,
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image, color: Colors.white54),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                movie.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber[700]),
                  const SizedBox(width: 4),
                  Text('${movie.rating} • ${movie.year}'),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                movie.overview,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => context.goNamed(
                  'player',
                  extra: {
                    'videoUrl': movie.videoUrl,
                    'title': movie.title,
                  },
                ),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Play'),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Không tìm thấy phim: $e')),
      ),
    );
  }
}

