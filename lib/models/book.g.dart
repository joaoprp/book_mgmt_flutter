// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

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

Author _$AuthorFromJson(Map<String, dynamic> json) =>
    Author(id: (json['id'] as num).toInt(), name: json['name'] as String);

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

const _$AuthorJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'id': {'type': 'integer'},
    'name': {'type': 'string'},
  },
  'required': ['id', 'name'],
};

Book _$BookFromJson(Map<String, dynamic> json) => Book(
  id: (json['id'] as num).toInt(),
  user: Author.fromJson(json['user'] as Map<String, dynamic>),
  title: json['title'] as String,
  pages: (json['pages'] as num).toInt(),
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
    'user': {r'$ref': r'#/$defs/Author'},
    'title': {'type': 'string'},
    'pages': {'type': 'integer'},
    'indexes': {
      'type': 'array',
      'items': {r'$ref': r'#/$defs/Index'},
    },
  },
  'required': ['id', 'user', 'title', 'pages'],
  r'$defs': {
    'Author': {
      'type': 'object',
      'properties': {
        'id': {'type': 'integer'},
        'name': {'type': 'string'},
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
