import 'package:flutter/material.dart';

extension ParagraphStyles on Text {
  Text copyWith(TextStyle? s) => Text(data!, style: s?.merge(style) ?? style);

  Text h1() => copyWith(.new(fontSize: 18, fontWeight: .bold));
}
