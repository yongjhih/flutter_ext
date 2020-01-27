library test_ext;

import 'package:test/test.dart' as test;

extension MatcherX<T extends test.Matcher> on T {
  void of<S>(S actual, {
    String reason,
    dynamic skip, // true or a String
  }) {
    test.expect(actual, this, reason: reason, skip: skip);
  }

  bool match<S>(S actual, {
    Map matchState,
  }) => matches(actual, matchState);
}

extension MatcherStringX<T extends String> on T {
  test.Matcher isIn() =>
    test.isIn(this);
}

extension MatcherIterableX<E> on Iterable<E> {
  test.Matcher isIn() =>
    test.isIn(this);

  void isHaving(E actual, {
    String reason,
    dynamic skip, // true or a String
  }) {
    isIn().of(actual,
      reason: reason,
      skip: skip,
    );
  }
}

extension MatcherMapX<T extends Map> on T {
  test.Matcher isIn() =>
    test.isIn(this);
}