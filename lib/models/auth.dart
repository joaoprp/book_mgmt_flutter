import 'package:book_mgmt/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable(createJsonSchema: true)
class Auth {
  final String message;
  final User user;
  final String token;

  Auth({required this.message, required this.user, required this.token});

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);

  Map<String, dynamic> toJson() => _$AuthToJson(this);

  static const jsonSchema = _$AuthJsonSchema;
}
