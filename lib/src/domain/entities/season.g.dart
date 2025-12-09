// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SeasonImpl _$$SeasonImplFromJson(Map<String, dynamic> json) => _$SeasonImpl(
  id: json['id'] as String,
  seasonNumber: (json['seasonNumber'] as num).toInt(),
  episodeIds: (json['episodeIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$$SeasonImplToJson(_$SeasonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'seasonNumber': instance.seasonNumber,
      'episodeIds': instance.episodeIds,
    };
