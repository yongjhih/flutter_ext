library streamx;

extension StreamX<T> on Stream<T> {
  Stream<T> distinctBy<R>(R comsume(T it)) =>
    distinct((prev, next) => comsume(prev) == comsume(next));

  Future<T> firstOrNull() async =>
    firstWhere((it) => true, orElse: () => null);
}

extension IterableStreamX<T> on Iterable<T> {
  Stream<T> toStream() => Stream.fromIterable(this);
}
