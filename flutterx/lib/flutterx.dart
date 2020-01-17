library flutterx;

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

// TODO: Move to dartx
extension AsX<T extends Object> on T {
  R as<R>() => this is R ? this as R : null;
}