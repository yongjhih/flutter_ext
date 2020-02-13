import 'package:test/test.dart';

import 'package:rxdartx/rxdartx.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  test('.minBy()', () async {
    expect(await Stream.fromIterable(["1", "12", "123"])
      .min((prev, next) => prev.length.compareTo(next.length)), "1");
    expect(await Stream.fromIterable(["1", "12", "123"])
      .minBy<num>((it) => it.length), "1");
    expect(await Stream.fromIterable(["1", "12", "123"])
      .minBy<num>((it) => it.length), await Stream.fromIterable(["1", "12", "123"])
      .min((prev, next) => prev.length.compareTo(next.length)));
  });
  test('.maxBy()', () async {
    expect(await Stream.fromIterable(["1", "12", "123"])
      .max((prev, next) => prev.length.compareTo(next.length)), "123");
    expect(await Stream.fromIterable(["1", "12", "123"])
      .maxBy<num>((it) => it.length), "123");
    expect(await Stream.fromIterable(["1", "12", "123"])
      .maxBy<num>((it) => it.length), await Stream.fromIterable(["1", "12", "123"])
      .max((prev, next) => prev.length.compareTo(next.length)));
  });

  test('.mapTo()', () async {
    await expectLater(Rx.range(1, 4).mapTo(true),
        emitsInOrder(<dynamic>[true, true, true, true, emitsDone]));
    await expectLater(Rx.range(1, 4).map((it) => true),
        emitsInOrder(<dynamic>[true, true, true, true, emitsDone]));
    expect(await Stream.fromIterable(["1", "12", "123"])
      .mapTo(true).toList(), await Stream.fromIterable(["1", "12", "123"])
      .map((it) => true).toList());
  });

  test('.distinctUniqueBy()', () async {
    await expectLater(
        Stream.fromIterable(['1234', '1234', 'abcd', 'abc', '1234', 'abcd', '123'])
          .distinctUnique(equals: (it, that) => it.length == that.length, hashCode: (it) => it.length.hashCode),
        emitsInOrder(<dynamic>[
          '1234',
          'abc',
          emitsDone
        ]));
    await expectLater(
        Stream.fromIterable(['1234', '1234', 'abcd', 'abc', '1234', 'abcd', '123'])
          .distinctUniqueBy((it) => it.length),
        emitsInOrder(<dynamic>[
          '1234',
          'abc',
          emitsDone
        ]));
  });
}