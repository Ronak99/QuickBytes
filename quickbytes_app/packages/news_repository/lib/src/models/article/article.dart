// ignore_for_file: invalid_annotation_target

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../news_category/news_category.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
class Article with _$Article {
  const Article._();

  const factory Article({
    required String id,
    required String title,
    required String content,
    required String image,
    @JsonKey(name: 'source_url') required String sourceUrl,
    @JsonKey(name: 'published_on') required DateTime publishedOn,
    @JsonKey(fromJson: _categoriesFromJson)
    required List<NewsCategory> categories,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}

List<NewsCategory> _categoriesFromJson(dynamic json) {
  final List<dynamic> categoriesJson = json;

  final List<Map<String, dynamic>> categoriesMapList = categoriesJson
      .map((e) =>
          (e as Map).map((key, value) => MapEntry(key.toString(), value)))
      .toList();

  return categoriesMapList.map((e) => NewsCategory.fromJson(e)).toList();
}
