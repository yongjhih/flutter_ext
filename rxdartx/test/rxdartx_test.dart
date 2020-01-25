import 'package:test/test.dart';

import 'package:rxdartx/rxdartx.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  test('.distinctBy()', () async {
    expect(await Stream.fromIterable(["123", "abc"])
      .distinct((prev, next) => prev.length == next.length).last, "123");
    expect(await Stream.fromIterable(["123", "abc"])
      .distinctBy((it) => it.length).last, "123");
  });
}