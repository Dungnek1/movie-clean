import '../entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> fetchPopularMovies();
  Future<Movie> fetchMovieById(String id);
}

