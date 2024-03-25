// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArticleImpl _$$ArticleImplFromJson(Map<String, dynamic> json) =>
    _$ArticleImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      image: json['image'] as String,
      categoryList: (json['category_list'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      sourceUrl: json['source_url'] as String,
      relevancy: $enumDecode(_$RelevancyEnumMap, json['relevancy']),
      publishedOn: DateTime.parse(json['published_on'] as String),
    );

Map<String, dynamic> _$$ArticleImplToJson(_$ArticleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'category_list': instance.categoryList,
      'source_url': instance.sourceUrl,
      'relevancy': _$RelevancyEnumMap[instance.relevancy]!,
      'published_on': instance.publishedOn.toIso8601String(),
    };

const _$RelevancyEnumMap = {
  Relevancy.all: 'all',
  Relevancy.major: 'major',
};
