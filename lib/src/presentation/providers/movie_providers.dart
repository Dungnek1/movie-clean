import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dio/dio.dart';

import '../../data/datasources/movie_remote_data_source.dart';
import '../../data/datasources/local_json_movie_remote_data_source.dart';
import '../../data/datasources/tmdb_movie_remote_data_source.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';

const _tmdbKey =
    String.fromEnvironment('TMDB_API_KEY', defaultValue: '');

final movieRemoteDataSourceProvider = Provider<MovieRemoteDataSource>((ref) {
  if (_tmdbKey.isNotEmpty) {
    return TmdbMovieRemoteDataSource(dio: Dio(), apiKey: _tmdbKey);
  }
  return LocalJsonMovieRemoteDataSource();
});

final movieRepositoryProvider = Provider<MovieRepository>(
  (ref) => MovieRepositoryImpl(ref.read(movieRemoteDataSourceProvider)),
);

final popularMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final repo = ref.watch(movieRepositoryProvider);
  return repo.fetchPopularMovies();
});

final movieDetailProvider =
    FutureProvider.family<Movie, String>((ref, id) async {
  final repo = ref.watch(movieRepositoryProvider);
  return repo.fetchMovieById(id);
});

