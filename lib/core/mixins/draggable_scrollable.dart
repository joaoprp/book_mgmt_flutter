import 'package:book_mgmt/core/enums/index.dart';
import 'package:flutter/material.dart';

mixin DraggableScrollable {
  final sheetController = DraggableScrollableController();
  double turns = AddReadyState.open.value;

  void toggleAnimation(Function setState) {
    final sheetSize = sheetController.size;

    sheetController.animateTo(
      sheetSize > 0 ? SheetState.open.value : SheetState.close.value,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );

    setState(
      () => turns = sheetSize > 0
          ? AddReadyState.open.value
          : AddReadyState.close.value,
    );
  }
}
