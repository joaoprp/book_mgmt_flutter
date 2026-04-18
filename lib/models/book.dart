import 'package:book_mgmt/models/indice.dart';
import 'package:book_mgmt/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable(createJsonSchema: true)
class Book {
  final int id;
  final User user;
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
