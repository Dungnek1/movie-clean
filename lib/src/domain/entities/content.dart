import 'package:freezed_annotation/freezed_annotation.dart';

part 'content.freezed.dart';
part 'content.g.dart';

@freezed
class Content with _$Content {
  const factory Content({
    required String id,
    required String title,
    required String overview,
    required String posterUrl,
    required String backdropUrl,
    required List<String> genres,
    required String releaseDate,
  }) = _Content;

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
}

