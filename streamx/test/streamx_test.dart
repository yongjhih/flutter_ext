import 'package:test/test.dart';

import 'package:streamx/streamx.dart';

void main() {
  test('.distinctBy()', () async {
    expect(await Stream.fromIterable(["123", "abc"])
      .distinct((prev, next) => prev.length == next.length).last, "123");
    expect(await Stream.fromIterable(["123", "abc"])
      .distinctBy((it) => it.length).last, "123");
  });

  test('Callable.asStream', () async {
    await expectLater(
      (() => "hello").asStream(),
      emitsInOrder(<dynamic>["hello", emitsDone]),
    );
    await expectLater(
      (() => throw Exception()).asStream(),
      emitsInOrder(<dynamic>[emitsError(isException), emitsDone]),
    );
  });

  test('FutureCallable.asStream', () async {
    await expectLater(
      (() => Future.value("hello")).asStream(),
      emitsInOrder(<dynamic>["hello", emitsDone]),
    );
    await expectLater(
      (() => Future.error(Exception())).asStream(),
      emitsInOrder(<dynamic>[emitsError(isException), emitsDone]),
    );
  });

  test('Future.asStream', () async {
    await expectLater(
      (() async => "hello").asStream(),
      emitsInOrder(<dynamic>["hello", emitsDone]),
    );
    await expectLater(
      Future.value("hello").asStream(),
      emitsInOrder(<dynamic>["hello", emitsDone]),
    );
    await expectLater(
      Future.error(Exception()).asStream(),
      emitsInOrder(<dynamic>[emitsError(isException), emitsDone]),
    );
  });

  test('Futures.asStream', () async {
    await expectLater(
      [Future.value("hello"), Future.value("world")].asStream(),
      emitsInOrder(<dynamic>["hello", "world", emitsDone]),
    );
  });

  test('Iterable.asStream', () async {
    await expectLater(
      ["hello", "world"].asStream(),
      emitsInOrder(<dynamic>["hello", "world", emitsDone]),
    );
  });
}
