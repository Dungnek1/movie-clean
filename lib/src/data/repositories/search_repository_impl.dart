import '../../domain/entities/movie.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/movie_remote_data_source.dart';

class SearchRepositoryImpl implements SearchRepository {
  final MovieRemoteDataSource remote;
  SearchRepositoryImpl(this.remote);

  @override
  Future<List<Movie>> search(String query) {
    return remote.fetchPopularMovies().then((list) {
      final lower = query.toLowerCase();
      return list
          .where((m) =>
              m.title.toLowerCase().contains(lower) ||
              m.overview.toLowerCase().contains(lower))
          .map((m) => m.toDomain())
          .toList();
    });
  }
}

