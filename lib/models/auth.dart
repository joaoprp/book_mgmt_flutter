class AuthUser {
  final int id;
  final String name;
  final String email;

  AuthUser({required this.id, required this.name, required this.email});

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'name': String name, 'email': String email} => AuthUser(
        id: id,
        name: name,
        email: email,
      ),
      _ => throw const FormatException('Failed to cast Auth User.'),
    };
  }
}

class AuthModel {
  final String message;
  final AuthUser user;
  final String token;

  AuthModel({required this.message, required this.user, required this.token});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'message': String message,
        'user': dynamic user,
        'token': String token,
      } =>
        AuthModel(
          message: message,
          user: AuthUser.fromJson(user),
          token: token,
        ),
      _ => throw const FormatException('Failed to cast Auth Model.'),
    };
  }
}
