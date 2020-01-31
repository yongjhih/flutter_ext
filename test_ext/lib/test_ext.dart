library test_ext;

import 'package:test/test.dart' as test;

extension MatcherX<T extends test.Matcher> on T {
  void of<S>(S actual, {
    String reason,
    dynamic skip, // true or a String
  }) {
    test.expect(actual, this, reason: reason, skip: skip);
  }

  void to<S>(S actual, {
    String reason,
    dynamic skip, // true or a String
  }) => of(actual, reason: reason, skip: skip);

  bool match<S>(S actual, {
    Map matchState,
  }) => matches(actual, matchState);

  test.Matcher not() => _NotMatcher(this);
}

extension MatcherObjectX<T extends Object> on T {
  void shouldBeEmpty({
    String reason,
    dynamic skip, // true or a String
  }) {
    print("MatcherObjectX.shouldBeEmpty");
    test.isEmpty.of(this, reason: reason, skip: skip);
  }
  void shouldBeNotEmpty({
    String reason,
    dynamic skip, // true or a String
  }) {
    print("MatcherObjectX.shouldBeNotEmpty");
    test.isNotEmpty.of<T>(this, reason: reason, skip: skip);
  }
}

class _NotMatcher extends test.Matcher {
  const _NotMatcher(this._matcher);
  final test.Matcher _matcher;
  @override
  bool matches(item, Map matchState) => !_matcher.matches(item, matchState);

  @override
  test.Description describe(test.Description description) => _matcher.describe(description).add("not");
}

class TypedMatcher<T> extends test.Matcher {

  const TypedMatcher({this.actual});

  final T actual;

  bool shouldMatch(T item, Map matchState) => false;

  @override
  bool matches(item, Map matchState) => shouldMatch(item, matchState);

  @override
  test.Description describe(test.Description description) => description;


  void shouldBeEmpty({
    String reason,
    dynamic skip, // true or a String
  }) {
    print("TypedMatcher.shouldBeEmpty");
    if (actual != null) {
      actual.shouldBeEmpty(reason: reason, skip: skip);
    } else {
      test.isEmpty.of(actual, reason: reason, skip: skip);
    }
  }
}

const test.Matcher isStringEmpty = _StringEmptyMatcher();
const test.Matcher isStringNotEmpty = _StringNotEmptyMatcher();

class _StringNotEmptyMatcher extends TypedMatcher<String> {
  const _StringNotEmptyMatcher() : super(actual: null);

  @override
  bool shouldMatch(String item, Map matchState) => !item.isEmpty;

  @override
  test.Description describe(test.Description description) => description.add('not empty');
}

class _StringEmptyMatcher extends TypedMatcher<String> {
  const _StringEmptyMatcher() : super(actual: null);

  @override
  bool shouldMatch(String item, Map matchState) => item.isEmpty;

  @override
  test.Description describe(test.Description description) => description.add('empty');
}

extension MatcherStringX<T extends String> on T {
  test.Matcher isIn() =>
    test.isIn(this);

  void shouldBeEmpty({
    String reason,
    dynamic skip, // true or a String
  }) {
    print("MatcherStringX.shouldBeEmpty()");
    test.expect(this, isStringEmpty, reason: reason, skip: skip);
  }

  void shouldBeNotEmpty({
    String reason,
    dynamic skip, // true or a String
  }) {
    print("MatcherStringX.shouldBeEmpty()");
    test.expect(this, isStringNotEmpty, reason: reason, skip: skip);
  }
}

/// Dart doesn't support overloading, that's no way to do this.
/// 
/// We expect assertThat<String>().shouldNotEmpty()
/// should call String.shouldNotEmpty() if T is String,
/// but it's still calling Object.shouldNotEmpty()
TypedMatcher<T> assertThat<T>(T actual) {
  return TypedMatcher<T>(actual: actual);
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
