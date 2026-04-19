// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  pages: Book._intFromString(json['pages']),
  user: json['user'] == null
      ? null
      : User.fromJson(json['user'] as Map<String, dynamic>),
  indexes: (json['indexes'] as List<dynamic>?)
      ?.map((e) => Index.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
  'id': instance.id,
  'user': instance.user,
  'title': instance.title,
  'pages': instance.pages,
  'indexes': instance.indexes,
};

const _$BookJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'id': {'type': 'integer'},
    'user': {r'$ref': r'#/$defs/User'},
    'title': {'type': 'string'},
    'pages': {'type': 'integer'},
    'indexes': {
      'type': 'array',
      'items': {r'$ref': r'#/$defs/Index'},
    },
  },
  'required': ['id', 'title', 'pages'],
  r'$defs': {
    'User': {
      'type': 'object',
      'properties': {
        'id': {'type': 'integer'},
        'name': {'type': 'string'},
        'email': {'type': 'string'},
      },
      'required': ['id', 'name'],
    },
    'Index': {
      'type': 'object',
      'properties': {
        'id': {'type': 'integer'},
        'title': {'type': 'string'},
        'page': {'type': 'integer'},
        'children': {
          'type': 'array',
          'items': {r'$ref': r'#/$defs/Index'},
        },
      },
      'required': ['id', 'title', 'page'],
    },
  },
};
