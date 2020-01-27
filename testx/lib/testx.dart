library testx;

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
  }) {
    return matches(actual, matchState);
  }
}