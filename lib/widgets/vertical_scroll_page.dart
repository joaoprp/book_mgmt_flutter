import 'package:flutter/material.dart';

typedef AddConstructorType =
    Function({
      required ScrollController controller,
      required VoidCallback callback,
      Key? key,
    });

class VerticalDrawerPage extends StatelessWidget {
  final DraggableScrollableController controller;
  final AddConstructorType data;
  final VoidCallback callback;
  const VerticalDrawerPage(
    this.data, {
    super.key,
    required this.controller,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: controller,
      initialChildSize: 0,
      minChildSize: 0,
      maxChildSize: 0.9,
      builder: builder(data, callback),
    );
  }
}

ScrollableWidgetBuilder builder(
  AddConstructorType data,
  VoidCallback callback,
) => (BuildContext context, ScrollController scrollController) {
  return Container(
    padding: .symmetric(horizontal: 40),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.5),
          spreadRadius: 5,
          blurRadius: 7,
        ),
      ],
      color: Colors.white,
      borderRadius: .vertical(top: .circular(20)),
    ),
    child: data(controller: scrollController, callback: callback),
  );
};
