import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Movie>> fetchPopularMovies() {
    return remoteDataSource
        .fetchPopularMovies()
        .then((list) => list.map((m) => m.toDomain()).toList());
  }

  @override
  Future<Movie> fetchMovieById(String id) {
    return remoteDataSource.fetchMovieById(id).then((m) => m.toDomain());
  }
}

