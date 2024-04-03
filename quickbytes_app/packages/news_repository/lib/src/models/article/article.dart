// ignore_for_file: invalid_annotation_target

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';
part 'article.g.dart';

enum Relevancy {
  all,
  major,
}

@freezed
class Article with _$Article {
  const Article._();

  const factory Article({
    required String id,
    required String title,
    required String content,
    required String image,
    @JsonKey(name: 'category_list') required List<String> categoryList,
    @JsonKey(name: 'source_url') required String sourceUrl,
    required Relevancy relevancy,
    @JsonKey(name: 'published_on') required DateTime publishedOn,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}
