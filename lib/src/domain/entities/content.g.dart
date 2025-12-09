// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentImpl _$$ContentImplFromJson(Map<String, dynamic> json) =>
    _$ContentImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      overview: json['overview'] as String,
      posterUrl: json['posterUrl'] as String,
      backdropUrl: json['backdropUrl'] as String,
      genres: (json['genres'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      releaseDate: json['releaseDate'] as String,
    );

Map<String, dynamic> _$$ContentImplToJson(_$ContentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'posterUrl': instance.posterUrl,
      'backdropUrl': instance.backdropUrl,
      'genres': instance.genres,
      'releaseDate': instance.releaseDate,
    };
