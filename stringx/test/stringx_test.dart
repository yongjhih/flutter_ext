import 'package:test/test.dart';

import 'package:test_ext/test_ext.dart';
import 'package:stringx/stringx.dart';

void main() {
  test('should String.toSuperscript', () {
    final s = "+1";
    equals("+1⁺¹").of("${s}${s.toSupscript()}");
    equals("+1₊₁").of("${s}${s.toSubscript()}");
  });
  test('should Map.mergeWith', () {
    final x = <String, int>{
      "a": null,
      "ab": null,
      "abc": null,
    };
    final y = <String, int>{
    "ab": 2,
    };
    final expectedXy = <String, int>{
      "a": null,
      "ab": 2,
      "abc": null,
    };
    equals(expectedXy).of(x.mergeWith(y));
  });
  test('should Map.mergeWith(empty)', () {
    final a = <String, int>{
      "a": null,
      "ab": null,
      "abc": null,
    };
    final b = <String, int>{};
    final expected = <String, int>{
      "a": null,
      "ab": null,
      "abc": null,
    };
    equals(expected).of(a.mergeWith(b));
  });
  test('should Map.mergeWith() from empty', () {
    final a = <String, int>{};
    final b = <String, int>{
      "a": null,
      "ab": null,
      "abc": null,
    };
    final expected = <String, int>{};
    equals(expected).of(a.mergeWith(b, putIfAbsent: false));
  });
  test('should Map.mergeWith(empty) from empty', () {
    final a = <String, int>{
    };
    final b = <String, int>{
    };
    final expected = <String, int>{
    };
    equals(expected).of(a.mergeWith(b));
  });
}
