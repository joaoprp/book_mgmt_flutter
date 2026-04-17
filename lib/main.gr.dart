// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:book_mgmt/pages/books/add.dart' as _i1;
import 'package:book_mgmt/pages/books/list.dart' as _i2;
import 'package:book_mgmt/pages/login.dart' as _i3;
import 'package:book_mgmt/pages/register.dart' as _i4;

/// generated route for
/// [_i1.AddBook]
class AddBook extends _i5.PageRouteInfo<void> {
  const AddBook({List<_i5.PageRouteInfo>? children})
    : super(AddBook.name, initialChildren: children);

  static const String name = 'AddBook';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddBook();
    },
  );
}

/// generated route for
/// [_i2.LibraryView]
class LibraryView extends _i5.PageRouteInfo<void> {
  const LibraryView({List<_i5.PageRouteInfo>? children})
    : super(LibraryView.name, initialChildren: children);

  static const String name = 'LibraryView';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.LibraryView();
    },
  );
}

/// generated route for
/// [_i3.Login]
class Login extends _i5.PageRouteInfo<void> {
  const Login({List<_i5.PageRouteInfo>? children})
    : super(Login.name, initialChildren: children);

  static const String name = 'Login';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.Login();
    },
  );
}

/// generated route for
/// [_i4.Register]
class Register extends _i5.PageRouteInfo<void> {
  const Register({List<_i5.PageRouteInfo>? children})
    : super(Register.name, initialChildren: children);

  static const String name = 'Register';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.Register();
    },
  );
}
