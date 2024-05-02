// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewsCategoryImpl _$$NewsCategoryImplFromJson(Map<String, dynamic> json) =>
    _$NewsCategoryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      label: json['label'] as String,
      relevancy: $enumDecode(_$RelevancyEnumMap, json['relevancy']),
    );

Map<String, dynamic> _$$NewsCategoryImplToJson(_$NewsCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'label': instance.label,
      'relevancy': _$RelevancyEnumMap[instance.relevancy]!,
    };

const _$RelevancyEnumMap = {
  Relevancy.all: 'all',
  Relevancy.major: 'major',
  Relevancy.none: 'none',
};
