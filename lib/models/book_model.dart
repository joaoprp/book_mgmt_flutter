class Index {
  final String title;
  final int page;
  final List<Index>? children;

  Index({required this.title, required this.page, this.children});

  factory Index.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'title': String title, 'page': int page} => Index(
        title: title,
        page: page,
      ),
      _ => throw const FormatException('Failed to cast Index from Book.'),
    };
  }
}

class Author {
  final int id;
  final String name;

  Author({required this.id, required this.name});

  factory Author.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'name': String name} => Author(id: id, name: name),
      _ => throw const FormatException('Failed to cast Author on Book Model.'),
    };
  }
}

class BookModel {
  final int id;
  final Author user;
  final String title;
  final int pages;
  final List<Index>? indexes;

  BookModel({
    required this.id,
    required this.user,
    required this.title,
    required this.pages,
    this.indexes,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'title': String title,
        'user': dynamic user,
        'pages': int pages,
        'id': int id,
      } =>
        BookModel(
          id: id,
          user: Author.fromJson(user),
          title: title,
          pages: pages,
        ),

      _ => throw const FormatException('Failed to cast Book Model.'),
    };
  }
}
