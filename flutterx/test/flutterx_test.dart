import 'package:flutter_test/flutter_test.dart';

import 'package:flutterx/flutterx.dart';

void main() {
  test('should as<T>()', () async {
    const Object it = "Hello";
    expect(it?.as<String>() ?? "", "Hello");
    expect(it?.as<int>() ?? 0, 0);
    const nullIt = null;
    expect(nullIt?.as<String>() ?? "", "");
  });
}
