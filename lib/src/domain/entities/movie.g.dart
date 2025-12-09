// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MovieImpl _$$MovieImplFromJson(Map<String, dynamic> json) => _$MovieImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  overview: json['overview'] as String,
  posterUrl: json['poster_url'] as String,
  backdropUrl: json['backdrop_url'] as String,
  rating: (json['rating'] as num).toDouble(),
  year: json['year'] as String,
  videoUrl: json['video_url'] as String,
  genres: (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$$MovieImplToJson(_$MovieImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'posterUrl': instance.posterUrl,
      'backdropUrl': instance.backdropUrl,
      'rating': instance.rating,
      'year': instance.year,
      'videoUrl': instance.videoUrl,
      'genres': instance.genres,
    };
