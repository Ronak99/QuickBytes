// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return _Article.fromJson(json);
}

/// @nodoc
mixin _$Article {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_list')
  List<String> get categoryList => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_url')
  String get sourceUrl => throw _privateConstructorUsedError;
  Relevancy get relevancy => throw _privateConstructorUsedError;
  @JsonKey(name: 'published_on')
  DateTime get publishedOn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArticleCopyWith<Article> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleCopyWith<$Res> {
  factory $ArticleCopyWith(Article value, $Res Function(Article) then) =
      _$ArticleCopyWithImpl<$Res, Article>;
  @useResult
  $Res call(
      {String id,
      String title,
      String content,
      String image,
      @JsonKey(name: 'category_list') List<String> categoryList,
      @JsonKey(name: 'source_url') String sourceUrl,
      Relevancy relevancy,
      @JsonKey(name: 'published_on') DateTime publishedOn});
}

/// @nodoc
class _$ArticleCopyWithImpl<$Res, $Val extends Article>
    implements $ArticleCopyWith<$Res> {
  _$ArticleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? image = null,
    Object? categoryList = null,
    Object? sourceUrl = null,
    Object? relevancy = null,
    Object? publishedOn = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      categoryList: null == categoryList
          ? _value.categoryList
          : categoryList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sourceUrl: null == sourceUrl
          ? _value.sourceUrl
          : sourceUrl // ignore: cast_nullable_to_non_nullable
              as String,
      relevancy: null == relevancy
          ? _value.relevancy
          : relevancy // ignore: cast_nullable_to_non_nullable
              as Relevancy,
      publishedOn: null == publishedOn
          ? _value.publishedOn
          : publishedOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArticleImplCopyWith<$Res> implements $ArticleCopyWith<$Res> {
  factory _$$ArticleImplCopyWith(
          _$ArticleImpl value, $Res Function(_$ArticleImpl) then) =
      __$$ArticleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String content,
      String image,
      @JsonKey(name: 'category_list') List<String> categoryList,
      @JsonKey(name: 'source_url') String sourceUrl,
      Relevancy relevancy,
      @JsonKey(name: 'published_on') DateTime publishedOn});
}

/// @nodoc
class __$$ArticleImplCopyWithImpl<$Res>
    extends _$ArticleCopyWithImpl<$Res, _$ArticleImpl>
    implements _$$ArticleImplCopyWith<$Res> {
  __$$ArticleImplCopyWithImpl(
      _$ArticleImpl _value, $Res Function(_$ArticleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? image = null,
    Object? categoryList = null,
    Object? sourceUrl = null,
    Object? relevancy = null,
    Object? publishedOn = null,
  }) {
    return _then(_$ArticleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      categoryList: null == categoryList
          ? _value._categoryList
          : categoryList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sourceUrl: null == sourceUrl
          ? _value.sourceUrl
          : sourceUrl // ignore: cast_nullable_to_non_nullable
              as String,
      relevancy: null == relevancy
          ? _value.relevancy
          : relevancy // ignore: cast_nullable_to_non_nullable
              as Relevancy,
      publishedOn: null == publishedOn
          ? _value.publishedOn
          : publishedOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArticleImpl extends _Article with DiagnosticableTreeMixin {
  const _$ArticleImpl(
      {required this.id,
      required this.title,
      required this.content,
      required this.image,
      @JsonKey(name: 'category_list') required final List<String> categoryList,
      @JsonKey(name: 'source_url') required this.sourceUrl,
      required this.relevancy,
      @JsonKey(name: 'published_on') required this.publishedOn})
      : _categoryList = categoryList,
        super._();

  factory _$ArticleImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArticleImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String content;
  @override
  final String image;
  final List<String> _categoryList;
  @override
  @JsonKey(name: 'category_list')
  List<String> get categoryList {
    if (_categoryList is EqualUnmodifiableListView) return _categoryList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categoryList);
  }

  @override
  @JsonKey(name: 'source_url')
  final String sourceUrl;
  @override
  final Relevancy relevancy;
  @override
  @JsonKey(name: 'published_on')
  final DateTime publishedOn;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Article(id: $id, title: $title, content: $content, image: $image, categoryList: $categoryList, sourceUrl: $sourceUrl, relevancy: $relevancy, publishedOn: $publishedOn)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Article'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('image', image))
      ..add(DiagnosticsProperty('categoryList', categoryList))
      ..add(DiagnosticsProperty('sourceUrl', sourceUrl))
      ..add(DiagnosticsProperty('relevancy', relevancy))
      ..add(DiagnosticsProperty('publishedOn', publishedOn));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArticleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.image, image) || other.image == image) &&
            const DeepCollectionEquality()
                .equals(other._categoryList, _categoryList) &&
            (identical(other.sourceUrl, sourceUrl) ||
                other.sourceUrl == sourceUrl) &&
            (identical(other.relevancy, relevancy) ||
                other.relevancy == relevancy) &&
            (identical(other.publishedOn, publishedOn) ||
                other.publishedOn == publishedOn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      content,
      image,
      const DeepCollectionEquality().hash(_categoryList),
      sourceUrl,
      relevancy,
      publishedOn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArticleImplCopyWith<_$ArticleImpl> get copyWith =>
      __$$ArticleImplCopyWithImpl<_$ArticleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArticleImplToJson(
      this,
    );
  }
}

abstract class _Article extends Article {
  const factory _Article(
      {required final String id,
      required final String title,
      required final String content,
      required final String image,
      @JsonKey(name: 'category_list') required final List<String> categoryList,
      @JsonKey(name: 'source_url') required final String sourceUrl,
      required final Relevancy relevancy,
      @JsonKey(name: 'published_on')
      required final DateTime publishedOn}) = _$ArticleImpl;
  const _Article._() : super._();

  factory _Article.fromJson(Map<String, dynamic> json) = _$ArticleImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get content;
  @override
  String get image;
  @override
  @JsonKey(name: 'category_list')
  List<String> get categoryList;
  @override
  @JsonKey(name: 'source_url')
  String get sourceUrl;
  @override
  Relevancy get relevancy;
  @override
  @JsonKey(name: 'published_on')
  DateTime get publishedOn;
  @override
  @JsonKey(ignore: true)
  _$$ArticleImplCopyWith<_$ArticleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
