import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movie_providers.dart';
import '../../data/repositories/search_repository_impl.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/search_repository.dart';

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  final remote = ref.read(movieRemoteDataSourceProvider);
  return SearchRepositoryImpl(remote);
});

final searchResultsProvider =
    FutureProvider.family<List<Movie>, String>((ref, query) async {
  if (query.trim().isEmpty) return [];
  final repo = ref.watch(searchRepositoryProvider);
  return repo.search(query);
});

