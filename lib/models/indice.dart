import 'package:json_annotation/json_annotation.dart';

part 'indice.g.dart';

@JsonSerializable(createJsonSchema: true)
class Index {
  final int id;
  final String title;
  final int page;
  final List<Index>? children;

  Index({
    required this.id,
    required this.title,
    required this.page,
    this.children,
  });

  factory Index.fromJson(Map<String, dynamic> json) => _$IndexFromJson(json);

  Map<String, dynamic> toJson() => _$IndexToJson(this);

  static const jsonSchema = _$IndexJsonSchema;
}
