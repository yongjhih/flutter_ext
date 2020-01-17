import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_dtx/flutter_dtx.dart';

void main() {
  test('should as<T>()', () async {
    const Object it = "Hello";
    expect(it?.as<String>() ?? "", "Hello");
    expect(it?.as<int>() ?? 0, 0);
    const nullIt = null;
    expect(nullIt?.as<String>() ?? "", "");
  });
}
