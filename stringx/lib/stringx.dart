library stringx;

import 'package:dartx/dartx.dart';

extension StringX<T extends String> on T {
  String get orNull => isNotEmpty ? this : null;

  String truncate(int maximum, {String ellipsis = "..."}) =>
    length > maximum ? "${substrings(0, maximum)}${ellipsis}" : this;

  bool toBool() =>
    toLowerCase() == "true" || toLowerCase() == "on" || this == "1";

  String substrings(int startIndex, [int endIndex]) {
    startIndex = startIndex.coerceAtLeast(0);
    return (endIndex != null)
        ? substring(startIndex, endIndex?.coerceIn(0, length))
        : substring(startIndex);
  }

  bool endsWithIgnoreCase(String s) =>
      toLowerCase().endsWith(s.toLowerCase());

  bool startsWithIgnoreCase(String s) =>
    toLowerCase().endsWith(s.toLowerCase());

  bool equalsIgnoreCase(String s) =>
      toLowerCase() == s.toLowerCase();
        String toSupscript() =>
    codeUnits.map((it) => supscripts.getOrNull(it))
        .whereNotNull()
        .map((it) => String.fromCharCode(it))
        .join();

  String toSubscript() =>
    codeUnits.map((it) => subscripts.getOrNull(it))
        .whereNotNull()
        .map((it) => String.fromCharCode(it))
        .join();

  // TODO: Move into Character
  int toCodeUnit() => codeUnits.firstOrNull;

  // TODO: Move into Character
  int toRun() => runes.firstOrNull;

  int toCodeUnitOrNull() {
    try {
      return toCodeUnit();
    } on StateError {
      return null;
    }
  }

  int toRunOrNull() {
    try {
      return toRunOrNull();
    } on StateError {
      return null;
    }
  }
}

// Move to dartx or mapx
extension MapX<K, V> on Map<K, V> {
  Map<K, V> get orNull => isNotEmpty ? this : null;

  Map<K, V> notEmpty(Map<K, V> test()) => orNull ?? test();

  Map<K, V> mergeWith(Map<K, V> it, {V reduce(V that, V it),
    bool putIfAbsent = true,
  }) {
    final that = this; // ignore shadowed var

    it.forEach((k, v) {
      if (that.containsKey(k)) {
        if (reduce != null) {
          that[k] = reduce(that[k], v);
        } else {
          that[k] = v;
        }
      } else {
        if (putIfAbsent) {
          that.putIfAbsent(k, () => v);
        }
      }
    });
    return that;
  }

  V getOrNull(K key) => containsKey(key) ? this[key] : null;
}

// TODO: static const
final Map<int, int> subscripts = <int, int>{
  '0'.toCodeUnit()        : 0x2080,
  '1'.toCodeUnit()        : 0x2081,
  '2'.toCodeUnit()        : 0x2082,
  '3'.toCodeUnit()        : 0x2083,
  '4'.toCodeUnit()        : 0x2084,
  '5'.toCodeUnit()        : 0x2085,
  '6'.toCodeUnit()        : 0x2086,
  '7'.toCodeUnit()        : 0x2087,
  '8'.toCodeUnit()        : 0x2088,
  '9'.toCodeUnit()        : 0x2089,
  'a'.toCodeUnit()        : 0x2090,
  'e'.toCodeUnit()        : 0x2091,
  'h'.toCodeUnit()        : 0x2095,
  'i'.toCodeUnit()        : 0x1d62,
  'j'.toCodeUnit()        : 0x2c7c,
  'k'.toCodeUnit()        : 0x2096,
  'l'.toCodeUnit()        : 0x2097,
  'm'.toCodeUnit()        : 0x2098,
  'n'.toCodeUnit()        : 0x2099,
  'o'.toCodeUnit()        : 0x2092,
  'p'.toCodeUnit()        : 0x209a,
  'r'.toCodeUnit()        : 0x1d63,
  's'.toCodeUnit()        : 0x209b,
  't'.toCodeUnit()        : 0x209c,
  'u'.toCodeUnit()        : 0x1d64,
  'v'.toCodeUnit()        : 0x1d65,
  'x'.toCodeUnit()        : 0x2093,
  '+'.toCodeUnit()        : 0x208A,
  '-'.toCodeUnit()        : 0x208B,
  '='.toCodeUnit()        : 0x208C,
  '('.toCodeUnit()        : 0x208D,
  ')'.toCodeUnit()        : 0x208E,
};

// TODO: static const
final Map<int, int> supscripts = <int, int>{
  '0'.toCodeUnit()        : 0x2070,
  '1'.toCodeUnit()        : 0x00B9,
  '2'.toCodeUnit()        : 0x00B2,
  '3'.toCodeUnit()        : 0x00B3,
  '4'.toCodeUnit()        : 0x2074,
  '5'.toCodeUnit()        : 0x2075,
  '6'.toCodeUnit()        : 0x2076,
  '7'.toCodeUnit()        : 0x2077,
  '8'.toCodeUnit()        : 0x2078,
  '9'.toCodeUnit()        : 0x2079,
  'a'.toCodeUnit()        : 0x1d43,
  'b'.toCodeUnit()        : 0x1d47,
  'c'.toCodeUnit()        : 0x1d9c,
  'd'.toCodeUnit()        : 0x1d48,
  'e'.toCodeUnit()        : 0x1d49,
  'f'.toCodeUnit()        : 0x1da0,
  'g'.toCodeUnit()        : 0x1d4d,
  'h'.toCodeUnit()        : 0x02b0,
  'i'.toCodeUnit()        : 0x2071,
  'j'.toCodeUnit()        : 0x02b2,
  'k'.toCodeUnit()        : 0x1d4f,
  'l'.toCodeUnit()        : 0x02e1,
  'm'.toCodeUnit()        : 0x1d50,
  'n'.toCodeUnit()        : 0x207f,
  'o'.toCodeUnit()        : 0x1d52,
  'p'.toCodeUnit()        : 0x1d56,
  'r'.toCodeUnit()        : 0x02b3,
  's'.toCodeUnit()        : 0x02e2,
  't'.toCodeUnit()        : 0x1d57,
  'u'.toCodeUnit()        : 0x1d58,
  'v'.toCodeUnit()        : 0x1d5b,
  'w'.toCodeUnit()        : 0x02b7,
  'x'.toCodeUnit()        : 0x02e3,
  'y'.toCodeUnit()        : 0x02b8,
  'A'.toCodeUnit()        : 0x1d2c,
  'B'.toCodeUnit()        : 0x1d2e,
  'D'.toCodeUnit()        : 0x1d30,
  'E'.toCodeUnit()        : 0x1d31,
  'G'.toCodeUnit()        : 0x1d33,
  'H'.toCodeUnit()        : 0x1d34,
  'I'.toCodeUnit()        : 0x1d35,
  'J'.toCodeUnit()        : 0x1d36,
  'K'.toCodeUnit()        : 0x1d37,
  'L'.toCodeUnit()        : 0x1d38,
  'M'.toCodeUnit()        : 0x1d39,
  'N'.toCodeUnit()        : 0x1d3a,
  'O'.toCodeUnit()        : 0x1d3c,
  'P'.toCodeUnit()        : 0x1d3e,
  'R'.toCodeUnit()        : 0x1d3f,
  'T'.toCodeUnit()        : 0x1d40,
  'U'.toCodeUnit()        : 0x1d41,
  'V'.toCodeUnit()        : 0x2c7d,
  'W'.toCodeUnit()        : 0x1d42,
  '+'.toCodeUnit()        : 0x207A,
  '-'.toCodeUnit()        : 0x207B,
  '='.toCodeUnit()        : 0x207C,
  '('.toCodeUnit()        : 0x207D,
  ')'.toCodeUnit()        : 0x207E,
};