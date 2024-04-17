// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NewsCategory _$NewsCategoryFromJson(Map<String, dynamic> json) {
  return _NewsCategory.fromJson(json);
}

/// @nodoc
mixin _$NewsCategory {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  Relevancy get relevancy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NewsCategoryCopyWith<NewsCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsCategoryCopyWith<$Res> {
  factory $NewsCategoryCopyWith(
          NewsCategory value, $Res Function(NewsCategory) then) =
      _$NewsCategoryCopyWithImpl<$Res, NewsCategory>;
  @useResult
  $Res call({String id, String name, String label, Relevancy relevancy});
}

/// @nodoc
class _$NewsCategoryCopyWithImpl<$Res, $Val extends NewsCategory>
    implements $NewsCategoryCopyWith<$Res> {
  _$NewsCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? label = null,
    Object? relevancy = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      relevancy: null == relevancy
          ? _value.relevancy
          : relevancy // ignore: cast_nullable_to_non_nullable
              as Relevancy,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewsCategoryImplCopyWith<$Res>
    implements $NewsCategoryCopyWith<$Res> {
  factory _$$NewsCategoryImplCopyWith(
          _$NewsCategoryImpl value, $Res Function(_$NewsCategoryImpl) then) =
      __$$NewsCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String label, Relevancy relevancy});
}

/// @nodoc
class __$$NewsCategoryImplCopyWithImpl<$Res>
    extends _$NewsCategoryCopyWithImpl<$Res, _$NewsCategoryImpl>
    implements _$$NewsCategoryImplCopyWith<$Res> {
  __$$NewsCategoryImplCopyWithImpl(
      _$NewsCategoryImpl _value, $Res Function(_$NewsCategoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? label = null,
    Object? relevancy = null,
  }) {
    return _then(_$NewsCategoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      relevancy: null == relevancy
          ? _value.relevancy
          : relevancy // ignore: cast_nullable_to_non_nullable
              as Relevancy,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NewsCategoryImpl extends _NewsCategory {
  const _$NewsCategoryImpl(
      {required this.id,
      required this.name,
      required this.label,
      required this.relevancy})
      : super._();

  factory _$NewsCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewsCategoryImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String label;
  @override
  final Relevancy relevancy;

  @override
  String toString() {
    return 'NewsCategory(id: $id, name: $name, label: $label, relevancy: $relevancy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.relevancy, relevancy) ||
                other.relevancy == relevancy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, label, relevancy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsCategoryImplCopyWith<_$NewsCategoryImpl> get copyWith =>
      __$$NewsCategoryImplCopyWithImpl<_$NewsCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewsCategoryImplToJson(
      this,
    );
  }
}

abstract class _NewsCategory extends NewsCategory {
  const factory _NewsCategory(
      {required final String id,
      required final String name,
      required final String label,
      required final Relevancy relevancy}) = _$NewsCategoryImpl;
  const _NewsCategory._() : super._();

  factory _NewsCategory.fromJson(Map<String, dynamic> json) =
      _$NewsCategoryImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get label;
  @override
  Relevancy get relevancy;
  @override
  @JsonKey(ignore: true)
  _$$NewsCategoryImplCopyWith<_$NewsCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
