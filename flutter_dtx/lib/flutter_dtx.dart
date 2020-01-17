library flutter_dtx;

// TODO: Move to dartx
extension AsX<T extends Object> on T {
  R as<R>() => this is R ? this as R : null;
}
