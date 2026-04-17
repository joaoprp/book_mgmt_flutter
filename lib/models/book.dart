import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

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

@JsonSerializable(createJsonSchema: true)
class Author {
  final int id;
  final String name;

  Author({required this.id, required this.name});

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);

  static const jsonSchema = _$AuthorJsonSchema;
}

@JsonSerializable(createJsonSchema: true)
class Book {
  final int id;
  final Author user;
  final String title;
  final int pages;
  final List<Index>? indexes;

  Book({
    required this.id,
    required this.user,
    required this.title,
    required this.pages,
    this.indexes,
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);

  static const jsonSchema = _$BookJsonSchema;
}
