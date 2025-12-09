import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/movie.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class MovieModel with _$MovieModel {
  const factory MovieModel({
    required String id,
    required String title,
    required String overview,
    @JsonKey(name: 'poster_url')
    required String posterUrl,
    @JsonKey(name: 'backdrop_url')
    required String backdropUrl,
    required double rating,
    required String year,
    @JsonKey(name: 'video_url')
    required String videoUrl,
    required List<String> genres,
  }) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  const MovieModel._();

  Movie toDomain() => Movie(
    id: id,
    title: title,
    overview: overview,
    posterUrl: posterUrl,
    backdropUrl: backdropUrl,
    rating: rating,
    year: year,
    videoUrl: videoUrl,
    genres: genres,
  );
}
