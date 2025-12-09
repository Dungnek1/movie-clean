// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EpisodeImpl _$$EpisodeImplFromJson(Map<String, dynamic> json) =>
    _$EpisodeImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      overview: json['overview'] as String,
      videoUrl: json['videoUrl'] as String,
      seasonNumber: (json['seasonNumber'] as num).toInt(),
      episodeNumber: (json['episodeNumber'] as num).toInt(),
      runtime: json['runtime'] as String,
    );

Map<String, dynamic> _$$EpisodeImplToJson(_$EpisodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'videoUrl': instance.videoUrl,
      'seasonNumber': instance.seasonNumber,
      'episodeNumber': instance.episodeNumber,
      'runtime': instance.runtime,
    };
