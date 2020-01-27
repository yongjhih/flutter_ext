import 'package:test/test.dart';

import 'package:test_ext/test_ext.dart';

void main() {
  test("MatcherX" , () {
    isNotNull.of(1);
    isNull.of(null);
    isEmpty.of([]);
    equals([]).of([]);
    [1, 2, 3].isHaving(1);

    final list0 = [];
    same(list0).of(list0);

    predicate((x) => ((x % 2) == 0), "is even").of(0);

    same(list0).not().of([]);
    equals([]).not().of([1]);

    //expect(v, predicate((x) => ((x % 2) == 0), "is even"))
    //expect(isEmpty.match([]), isTrue);
    //final list0 = [];
    //expect(same(list0).match(list0), isTrue);
  });
}
