// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Index _$IndexFromJson(Map<String, dynamic> json) => Index(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  page: (json['page'] as num).toInt(),
  children: (json['children'] as List<dynamic>?)
      ?.map((e) => Index.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$IndexToJson(Index instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'page': instance.page,
  'children': instance.children,
};

const _$IndexJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'id': {'type': 'integer'},
    'title': {'type': 'string'},
    'page': {'type': 'integer'},
    'children': {
      'type': 'array',
      'items': {r'$ref': '#'},
    },
  },
  'required': ['id', 'title', 'page'],
};
