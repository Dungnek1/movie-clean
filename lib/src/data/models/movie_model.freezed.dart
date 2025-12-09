// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) {
  return _MovieModel.fromJson(json);
}

/// @nodoc
mixin _$MovieModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get overview => throw _privateConstructorUsedError;
  @JsonKey(name: 'poster_url')
  String get posterUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'backdrop_url')
  String get backdropUrl => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  String get year => throw _privateConstructorUsedError;
  @JsonKey(name: 'video_url')
  String get videoUrl => throw _privateConstructorUsedError;
  List<String> get genres => throw _privateConstructorUsedError;

  /// Serializes this MovieModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MovieModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MovieModelCopyWith<MovieModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieModelCopyWith<$Res> {
  factory $MovieModelCopyWith(
    MovieModel value,
    $Res Function(MovieModel) then,
  ) = _$MovieModelCopyWithImpl<$Res, MovieModel>;
  @useResult
  $Res call({
    String id,
    String title,
    String overview,
    @JsonKey(name: 'poster_url') String posterUrl,
    @JsonKey(name: 'backdrop_url') String backdropUrl,
    double rating,
    String year,
    @JsonKey(name: 'video_url') String videoUrl,
    List<String> genres,
  });
}

/// @nodoc
class _$MovieModelCopyWithImpl<$Res, $Val extends MovieModel>
    implements $MovieModelCopyWith<$Res> {
  _$MovieModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MovieModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? overview = null,
    Object? posterUrl = null,
    Object? backdropUrl = null,
    Object? rating = null,
    Object? year = null,
    Object? videoUrl = null,
    Object? genres = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            overview: null == overview
                ? _value.overview
                : overview // ignore: cast_nullable_to_non_nullable
                      as String,
            posterUrl: null == posterUrl
                ? _value.posterUrl
                : posterUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            backdropUrl: null == backdropUrl
                ? _value.backdropUrl
                : backdropUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as String,
            videoUrl: null == videoUrl
                ? _value.videoUrl
                : videoUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            genres: null == genres
                ? _value.genres
                : genres // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MovieModelImplCopyWith<$Res>
    implements $MovieModelCopyWith<$Res> {
  factory _$$MovieModelImplCopyWith(
    _$MovieModelImpl value,
    $Res Function(_$MovieModelImpl) then,
  ) = __$$MovieModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String overview,
    @JsonKey(name: 'poster_url') String posterUrl,
    @JsonKey(name: 'backdrop_url') String backdropUrl,
    double rating,
    String year,
    @JsonKey(name: 'video_url') String videoUrl,
    List<String> genres,
  });
}

/// @nodoc
class __$$MovieModelImplCopyWithImpl<$Res>
    extends _$MovieModelCopyWithImpl<$Res, _$MovieModelImpl>
    implements _$$MovieModelImplCopyWith<$Res> {
  __$$MovieModelImplCopyWithImpl(
    _$MovieModelImpl _value,
    $Res Function(_$MovieModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MovieModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? overview = null,
    Object? posterUrl = null,
    Object? backdropUrl = null,
    Object? rating = null,
    Object? year = null,
    Object? videoUrl = null,
    Object? genres = null,
  }) {
    return _then(
      _$MovieModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        overview: null == overview
            ? _value.overview
            : overview // ignore: cast_nullable_to_non_nullable
                  as String,
        posterUrl: null == posterUrl
            ? _value.posterUrl
            : posterUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        backdropUrl: null == backdropUrl
            ? _value.backdropUrl
            : backdropUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as String,
        videoUrl: null == videoUrl
            ? _value.videoUrl
            : videoUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        genres: null == genres
            ? _value._genres
            : genres // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MovieModelImpl extends _MovieModel {
  const _$MovieModelImpl({
    required this.id,
    required this.title,
    required this.overview,
    @JsonKey(name: 'poster_url') required this.posterUrl,
    @JsonKey(name: 'backdrop_url') required this.backdropUrl,
    required this.rating,
    required this.year,
    @JsonKey(name: 'video_url') required this.videoUrl,
    required final List<String> genres,
  }) : _genres = genres,
       super._();

  factory _$MovieModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MovieModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String overview;
  @override
  @JsonKey(name: 'poster_url')
  final String posterUrl;
  @override
  @JsonKey(name: 'backdrop_url')
  final String backdropUrl;
  @override
  final double rating;
  @override
  final String year;
  @override
  @JsonKey(name: 'video_url')
  final String videoUrl;
  final List<String> _genres;
  @override
  List<String> get genres {
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  @override
  String toString() {
    return 'MovieModel(id: $id, title: $title, overview: $overview, posterUrl: $posterUrl, backdropUrl: $backdropUrl, rating: $rating, year: $year, videoUrl: $videoUrl, genres: $genres)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.posterUrl, posterUrl) ||
                other.posterUrl == posterUrl) &&
            (identical(other.backdropUrl, backdropUrl) ||
                other.backdropUrl == backdropUrl) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            const DeepCollectionEquality().equals(other._genres, _genres));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    overview,
    posterUrl,
    backdropUrl,
    rating,
    year,
    videoUrl,
    const DeepCollectionEquality().hash(_genres),
  );

  /// Create a copy of MovieModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieModelImplCopyWith<_$MovieModelImpl> get copyWith =>
      __$$MovieModelImplCopyWithImpl<_$MovieModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MovieModelImplToJson(this);
  }
}

abstract class _MovieModel extends MovieModel {
  const factory _MovieModel({
    required final String id,
    required final String title,
    required final String overview,
    @JsonKey(name: 'poster_url') required final String posterUrl,
    @JsonKey(name: 'backdrop_url') required final String backdropUrl,
    required final double rating,
    required final String year,
    @JsonKey(name: 'video_url') required final String videoUrl,
    required final List<String> genres,
  }) = _$MovieModelImpl;
  const _MovieModel._() : super._();

  factory _MovieModel.fromJson(Map<String, dynamic> json) =
      _$MovieModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get overview;
  @override
  @JsonKey(name: 'poster_url')
  String get posterUrl;
  @override
  @JsonKey(name: 'backdrop_url')
  String get backdropUrl;
  @override
  double get rating;
  @override
  String get year;
  @override
  @JsonKey(name: 'video_url')
  String get videoUrl;
  @override
  List<String> get genres;

  /// Create a copy of MovieModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovieModelImplCopyWith<_$MovieModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
