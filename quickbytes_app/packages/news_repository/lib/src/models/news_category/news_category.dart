// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_category.freezed.dart';
part 'news_category.g.dart';

enum Relevancy {
  all,
  major,
}

@freezed
class NewsCategory with _$NewsCategory {
  const NewsCategory._();

  const factory NewsCategory({
    required String id,
    required String name,
    required Relevancy relevancy,
    required String label,
  }) = _NewsCategory;

  factory NewsCategory.fromJson(Map<String, dynamic> json) =>
      _$NewsCategoryFromJson(json);
}
