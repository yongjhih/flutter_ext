library rxdartx;

import 'package:rxdart/rxdart.dart';

extension StreamX<T> on Stream<T> {
  Future<T> maxBy<R extends Comparable<R>>(R comsume(T it)) =>
    max((prev, next) => comsume(prev).compareTo(comsume(next)));

  Future<T> minBy<R extends Comparable<R>>(R comsume(T it)) =>
    min((prev, next) => comsume(prev).compareTo(comsume(next)));

  Stream<T> distinctUniqueBy<R>(R comsume(T it)) =>
    distinctUnique(
      equals: (prev, next) => comsume(prev) == comsume(next),
      hashCode: (it) => comsume(it).hashCode
    );
}