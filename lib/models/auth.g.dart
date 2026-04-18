// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) => Auth(
  message: json['message'] as String,
  user: User.fromJson(json['user'] as Map<String, dynamic>),
  token: json['token'] as String,
);

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
  'message': instance.message,
  'user': instance.user,
  'token': instance.token,
};

const _$AuthJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'message': {'type': 'string'},
    'user': {r'$ref': r'#/$defs/User'},
    'token': {'type': 'string'},
  },
  'required': ['message', 'user', 'token'],
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
  },
};
