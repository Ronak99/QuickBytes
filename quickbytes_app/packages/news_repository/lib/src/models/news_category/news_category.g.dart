// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewsCategoryImpl _$$NewsCategoryImplFromJson(Map<String, dynamic> json) =>
    _$NewsCategoryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      relevancy: $enumDecode(_$RelevancyEnumMap, json['relevancy']),
      label: json['label'] as String,
    );

Map<String, dynamic> _$$NewsCategoryImplToJson(_$NewsCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'relevancy': _$RelevancyEnumMap[instance.relevancy]!,
      'label': instance.label,
    };

const _$RelevancyEnumMap = {
  Relevancy.all: 'all',
  Relevancy.major: 'major',
};
