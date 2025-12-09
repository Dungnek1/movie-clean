import 'package:dio/dio.dart';

import '../models/movie_model.dart';
import 'movie_remote_data_source.dart';

class TmdbMovieRemoteDataSource implements MovieRemoteDataSource {
  final Dio dio;
  final String apiKey;

  TmdbMovieRemoteDataSource({required this.dio, required this.apiKey});

  static const _base = 'https://api.themoviedb.org/3';
  static const _img = 'https://image.tmdb.org/t/p/w500';

  @override
  Future<List<MovieModel>> fetchPopularMovies() async {
    final res = await dio.get('$_base/movie/popular', queryParameters: {
      'api_key': apiKey,
      'language': 'en-US',
      'page': 1,
    });
    final results = res.data['results'] as List<dynamic>;
    return results
        .map<MovieModel>(
            (e) => _fromTmdb(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<MovieModel> fetchMovieById(String id) async {
    final res = await dio.get('$_base/movie/$id', queryParameters: {
      'api_key': apiKey,
      'language': 'en-US',
    });
    return _fromTmdb(res.data);
  }

  MovieModel _fromTmdb(Map<String, dynamic> json) {
    return MovieModel(
      id: (json['id']).toString(),
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterUrl: json['poster_path'] != null ? '$_img${json['poster_path']}' : '',
      backdropUrl:
          json['backdrop_path'] != null ? '$_img${json['backdrop_path']}' : '',
      rating: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      year: (json['release_date'] ?? '').toString().split('-').first,
      videoUrl:
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', // placeholder; real stream not in TMDB
      genres: (json['genre_ids'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
    );
  }
}

