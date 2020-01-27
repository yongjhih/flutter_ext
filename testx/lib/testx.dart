library testx;

import 'package:test/test.dart' as test;

Expector<T> expects<T>(T actual) {
  return Expector(actual);
}

class Expector<T> {
  T actual;

  Expector(T actual);

  void isTrue() {
    test.expect(actual, test.isTrue);
  }
  void isFalse() {
    test.expect(actual, test.isFalse);
  }

  void isNull() {
    test.expect(actual, test.isNull);
  }

  void isNotNull() {
    test.expect(actual, test.isNotNull);
  }

  void isNotEmpty() {
    test.expect(actual, test.isNotEmpty);
  }

  void isNaN() {
    test.expect(actual, test.isNaN);
  }

  void same(T expected) {
    test.expect(actual, test.same(expected));
  }

  void isA<S>() {
    test.expect(actual, test.isA<S>());
  }

  void returnsNormally() {
    test.expect(actual, test.returnsNormally);
  }

  void isMap() {
    test.expect(actual, test.isMap);
  }

  void hasLength(test.Matcher matcher) {
    test.expect(actual, test.hasLength(matcher));
  }

  void contains(expected) {
    test.expect(actual, test.contains(expected));
  }

  void isIn(expected) {
    test.expect(actual, test.isIn(expected));
  }

  void predicate<S>(bool f(S value),
      [String description = 'satisfies function']) {
    test.expect(actual, test.predicate<S>(f, description));
  }

}
