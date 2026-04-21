/*
  It looks a lot of unnecessary boilerplate to me adding
  every time the same variable and constructor for single
  default response type. Not having a way to wrap it is simply
  an eye sore.
*/

enum AddReadyState {
  open(0),
  close(0.125);

  final double value;
  const AddReadyState(this.value);
}

enum SheetState {
  open(0),
  close(0.9);

  final double value;
  const SheetState(this.value);
}
