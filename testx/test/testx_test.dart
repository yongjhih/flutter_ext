import 'package:test/test.dart';

import 'package:testx/testx.dart';

void main() {
  test("MatcherX" , () {
    isEmpty.of([]);
    final list0 = [];
    same(list0).of(list0);
    //expect(isEmpty.match([]), isTrue);
    //final list0 = [];
    //expect(same(list0).match(list0), isTrue);
  });
}
