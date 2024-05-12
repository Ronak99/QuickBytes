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
      sourceUrl: json['source_url'] as String,
      publishedOn: DateTime.parse(json['published_on'] as String),
      categories: _categoriesFromJson(json['categories']),
    );

Map<String, dynamic> _$$ArticleImplToJson(_$ArticleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'image': instance.image,
      'source_url': instance.sourceUrl,
      'published_on': instance.publishedOn.toIso8601String(),
      'categories': instance.categories,
    };
