// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SeriesImpl _$$SeriesImplFromJson(Map<String, dynamic> json) => _$SeriesImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  overview: json['overview'] as String,
  posterUrl: json['posterUrl'] as String,
  backdropUrl: json['backdropUrl'] as String,
  genres: (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
  releaseDate: json['releaseDate'] as String,
  seasons: (json['seasons'] as List<dynamic>)
      .map((e) => Season.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$SeriesImplToJson(_$SeriesImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'posterUrl': instance.posterUrl,
      'backdropUrl': instance.backdropUrl,
      'genres': instance.genres,
      'releaseDate': instance.releaseDate,
      'seasons': instance.seasons,
    };
