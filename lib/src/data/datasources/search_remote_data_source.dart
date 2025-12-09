import '../models/movie_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<MovieModel>> search(String query);
}

class MockSearchRemoteDataSource implements SearchRemoteDataSource {
  final List<MovieModel> seed;
  MockSearchRemoteDataSource(this.seed);

  @override
  Future<List<MovieModel>> search(String query) async {
    await Future.delayed(const Duration(milliseconds: 250));
    final lower = query.toLowerCase();
    return seed
        .where(
          (m) =>
              m.title.toLowerCase().contains(lower) ||
              m.overview.toLowerCase().contains(lower),
        )
        .toList();
  }
}
