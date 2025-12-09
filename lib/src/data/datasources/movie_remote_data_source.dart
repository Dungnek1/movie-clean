import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> fetchPopularMovies();
  Future<MovieModel> fetchMovieById(String id);
}

class MockMovieRemoteDataSource implements MovieRemoteDataSource {
  // Mock data simulating a remote API response.
  static const List<Map<String, dynamic>> _mockMovies = [
    {
      'id': '1',
      'title': 'Inception',
      'overview':
          'A thief who steals corporate secrets through the use of dream-sharing technology.',
      'poster_url':
          'https://image.tmdb.org/t/p/w500/qmDpIHrmpJINaRKAfWQfftjCdyi.jpg',
      'backdrop_url':
          'https://image.tmdb.org/t/p/original/s3TBrRGB1iav7gFOCNx3H31MoES.jpg',
      'rating': 8.8,
      'year': '2010',
      'video_url':
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      'genres': ['Action', 'Sci-Fi'],
    },
    {
      'id': '2',
      'title': 'Interstellar',
      'overview':
          'A team travels through a wormhole in space in an attempt to ensure humanity\'s survival.',
      'poster_url':
          'https://image.tmdb.org/t/p/w500/rAiYTfKGqDCRIIqo664sY9XZIvQ.jpg',
      'backdrop_url':
          'https://image.tmdb.org/t/p/original/xu9zaAevzQ5nnrsXN6JcahLnG4i.jpg',
      'rating': 8.6,
      'year': '2014',
      'video_url':
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      'genres': ['Adventure', 'Sci-Fi'],
    },
    {
      'id': '3',
      'title': 'The Dark Knight',
      'overview':
          'Batman faces the Joker, a criminal mastermind who wants to plunge Gotham City into anarchy.',
      'poster_url':
          'https://image.tmdb.org/t/p/w500/1hRoyzDtpgMU7Dz4JF22RANzQO7.jpg',
      'backdrop_url':
          'https://image.tmdb.org/t/p/original/hqkIcbrOHL86UncnHIsHVcVmzue.jpg',
      'rating': 9.0,
      'year': '2008',
      'video_url':
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
      'genres': ['Action', 'Crime'],
    },
  ];

  @override
  Future<List<MovieModel>> fetchPopularMovies() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockMovies.map((movie) => MovieModel.fromJson(movie)).toList();
  }

  @override
  Future<MovieModel> fetchMovieById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final data = _mockMovies.firstWhere((m) => m['id'] == id);
    return MovieModel.fromJson(data as Map<String, dynamic>);
  }

  List<MovieModel> get seed => _mockMovies.map((movie) => MovieModel.fromJson(movie)).toList();
}
