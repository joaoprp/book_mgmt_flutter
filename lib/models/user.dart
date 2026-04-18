import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(createJsonSchema: true)
class User {
  final int id;
  final String name;
  final String? email;

  User({required this.id, required this.name, this.email});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
  static const jsonSchema = _$UserJsonSchema;
}
