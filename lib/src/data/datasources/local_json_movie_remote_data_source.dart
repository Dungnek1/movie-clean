import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/movie_model.dart';
import 'movie_remote_data_source.dart';

class LocalJsonMovieRemoteDataSource implements MovieRemoteDataSource {
  LocalJsonMovieRemoteDataSource({this.assetPath = 'assets/movies.json'});

  final String assetPath;
  List<MovieModel>? _cache;

  Future<void> _ensureLoaded() async {
    if (_cache != null) return;
    final raw = await rootBundle.loadString(assetPath);
    final data = json.decode(raw) as Map<String, dynamic>;
    final list = data['movies'] as List<dynamic>;
    _cache = list.map((e) => MovieModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<MovieModel>> fetchPopularMovies() async {
    await _ensureLoaded();
    return _cache!;
  }

  @override
  Future<MovieModel> fetchMovieById(String id) async {
    await _ensureLoaded();
    return _cache!.firstWhere((m) => m.id == id);
  }

  List<MovieModel> get seed => _cache ?? [];
}

