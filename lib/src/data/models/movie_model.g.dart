// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'poster_url': instance.posterUrl,
      'backdrop_url': instance.backdropUrl,
      'rating': instance.rating,
      'year': instance.year,
      'video_url': instance.videoUrl,
      'genres': instance.genres,
    };

_$MovieModelImpl _$$MovieModelImplFromJson(Map<String, dynamic> json) =>
    _$MovieModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      overview: json['overview'] as String,
      posterUrl: json['poster_url'] as String,
      backdropUrl: json['backdrop_url'] as String,
      rating: (json['rating'] as num).toDouble(),
      year: json['year'] as String,
      videoUrl: json['video_url'] as String,
      genres: (json['genres'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$MovieModelImplToJson(_$MovieModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'poster_url': instance.posterUrl,
      'backdrop_url': instance.backdropUrl,
      'rating': instance.rating,
      'year': instance.year,
      'video_url': instance.videoUrl,
      'genres': instance.genres,
    };
