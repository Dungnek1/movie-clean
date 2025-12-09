import 'package:freezed_annotation/freezed_annotation.dart';

import 'season.dart';

part 'series.freezed.dart';
part 'series.g.dart';

@freezed
class Series with _$Series {
  const factory Series({
    required String id,
    required String title,
    required String overview,
    required String posterUrl,
    required String backdropUrl,
    required List<String> genres,
    required String releaseDate,
    required List<Season> seasons,
  }) = _Series;

  factory Series.fromJson(Map<String, dynamic> json) => _$SeriesFromJson(json);
}

