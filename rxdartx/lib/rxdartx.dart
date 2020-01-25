library rxdartx;

import 'package:rxdart/rxdart.dart';

extension RxX<T> on Stream<T> {
  Stream<T> distinctBy<R>(R comsume(T)) => distinct((prev, next) => comsume(prev) == comsume(next));
}