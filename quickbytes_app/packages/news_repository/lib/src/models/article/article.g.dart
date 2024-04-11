// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArticleImpl _$$ArticleImplFromJson(Map<String, dynamic> json) =>
    _$ArticleImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      image: json['image'] as String,
      categoryList: (json['categories'] as List<dynamic>)
          .map((e) => NewsCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      sourceUrl: json['source_url'] as String,
      publishedOn: DateTime.parse(json['published_on'] as String),
    );

Map<String, dynamic> _$$ArticleImplToJson(_$ArticleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'image': instance.image,
      'categories': instance.categoryList,
      'source_url': instance.sourceUrl,
      'published_on': instance.publishedOn.toIso8601String(),
    };
