import 'package:test/test.dart';

import 'package:time/time.dart';
import 'package:test_ext/test_ext.dart';
import 'package:datex/datex.dart';

void main() {
  test('should DateTimes.recentWeekday before', () async {
    /// S  M  T  W  T  F  S
    ///                   16
    /// 17 18 19 20 21 22 23
    /// 24 25 26 27 28 29 30
    final startDate = DateTimes.recentWeekday(6, from: DateTime(2019, 11, 22));

    final endDate = DateTimes.today(from: startDate, offsetDays: 7);
    expect(startDate, DateTime(2019, 11, 16));
    expect(endDate, DateTime(2019, 11, 23));
  });
  test('should DateTimes.recentWeekday', () async {
    /// S  M  T  W  T  F  S
    ///                   16
    /// 17 18 19 20 21 22 23
    /// 24 25 26 27 28 29 30
    final startDate = DateTimes.recentWeekday(6, from: DateTime(2019, 11, 23));
    final endDate = DateTimes.today(from: startDate, offsetDays: 7);
    expect(startDate, DateTime(2019, 11, 23));
    expect(endDate, DateTime(2019, 11, 30));
  });
  test('should DateTimes.recentWeekday after', () async {
    /// S  M  T  W  T  F  S
    ///                   23
    /// 24 25 26 27 28 29 30
    final startDate = DateTimes.recentWeekday(6, from: DateTime(2019, 11, 24));
    final endDate = DateTimes.today(from: startDate, offsetDays: 7);

    expect(startDate, DateTime(2019, 11, 23));
    expect(endDate, DateTime(2019, 11, 30));
  });
  test('should DateTimes.lastWeekday before', () async {
    /// S  M  T  W  T  F  S
    ///                   16
    /// 17 18 19 20 21 22 23
    /// 24 25 26 27 28 29 30
    final startDate = DateTimes.lastWeekday(6, from: DateTime(2019, 11, 22));
    final endDate = DateTimes.today(from: startDate, offsetDays: 7);
    expect(startDate, DateTime(2019, 11, 16));
    expect(endDate, DateTime(2019, 11, 23));
  });
  test('should DateTimes.lastWeekday', () async {
    /// S  M  T  W  T  F  S
    ///                   16
    /// 17 18 19 20 21 22 23
    /// 24 25 26 27 28 29 30
    final startDate = DateTimes.lastWeekday(6, from: DateTime(2019, 11, 23));
    final endDate = DateTimes.today(from: startDate, offsetDays: 7);
    expect(startDate, DateTime(2019, 11, 16));
    expect(endDate, DateTime(2019, 11, 23));
  });
  test('should DateTimes.lastWeekday after', () async {
    /// S  M  T  W  T  F  S
    ///                   16
    /// 17 18 19 20 21 22 23
    /// 24 25 26 27 28 29 30
    final startDate = DateTimes.lastWeekday(6, from: DateTime(2019, 11, 24));
    final endDate = DateTimes.today(from: startDate, offsetDays: 7);
    expect(startDate, DateTime(2019, 11, 23));
    expect(endDate, DateTime(2019, 11, 30));
  });

  test('should DateTime.rangeTo()', () async {
    isNotEmpty.of(DateTime(1984, 11, 19).range(1.days));

    equals([
      DateTime(1984, 11, 19, 0),
      DateTime(1984, 11, 19, 1),
      DateTime(1984, 11, 19, 2),
      DateTime(1984, 11, 19, 3),
      DateTime(1984, 11, 19, 4),
      DateTime(1984, 11, 19, 5),
      DateTime(1984, 11, 19, 6),
      DateTime(1984, 11, 19, 7),
      DateTime(1984, 11, 19, 8),
      DateTime(1984, 11, 19, 9),
      DateTime(1984, 11, 19, 10),
      DateTime(1984, 11, 19, 11),
      DateTime(1984, 11, 19, 12),
      DateTime(1984, 11, 19, 13),
      DateTime(1984, 11, 19, 14),
      DateTime(1984, 11, 19, 15),
      DateTime(1984, 11, 19, 16),
      DateTime(1984, 11, 19, 17),
      DateTime(1984, 11, 19, 18),
      DateTime(1984, 11, 19, 19),
      DateTime(1984, 11, 19, 20),
      DateTime(1984, 11, 19, 21),
      DateTime(1984, 11, 19, 22),
      DateTime(1984, 11, 19, 23),
      DateTime(1984, 11, 19, 24),
    ]).of(DateTime(1984, 11, 19).range(1.days).toList());

    equals([
      DateTime(1984, 11, 18, 0),
      DateTime(1984, 11, 18, 1),
      DateTime(1984, 11, 18, 2),
      DateTime(1984, 11, 18, 3),
      DateTime(1984, 11, 18, 4),
      DateTime(1984, 11, 18, 5),
      DateTime(1984, 11, 18, 6),
      DateTime(1984, 11, 18, 7),
      DateTime(1984, 11, 18, 8),
      DateTime(1984, 11, 18, 9),
      DateTime(1984, 11, 18, 10),
      DateTime(1984, 11, 18, 11),
      DateTime(1984, 11, 18, 12),
      DateTime(1984, 11, 18, 13),
      DateTime(1984, 11, 18, 14),
      DateTime(1984, 11, 18, 15),
      DateTime(1984, 11, 18, 16),
      DateTime(1984, 11, 18, 17),
      DateTime(1984, 11, 18, 18),
      DateTime(1984, 11, 18, 19),
      DateTime(1984, 11, 18, 20),
      DateTime(1984, 11, 18, 21),
      DateTime(1984, 11, 18, 22),
      DateTime(1984, 11, 18, 23),
      DateTime(1984, 11, 19, 0),
    ]).of(1.days.agoOf(DateTime(1984, 11, 19)).rangeTo(DateTime(1984, 11, 19)).toList());

    equals(1.days.agoOf(DateTime(1984, 11, 19)).rangeTo(DateTime(1984, 11, 19)).toList())
        .of(DateTime(1984, 11, 19).downTo(1.days.agoOf(DateTime(1984, 11, 19))).toList().reversed);
  });
  test('Duration.string()', () {
    expect(59.seconds.string(), "59 sec");
    expect(60.seconds.string(), "1 min");
    expect(
      Duration(days: 1, hours: 23, minutes: 3, seconds: 3).string(),
      "1 d 23 h 3 min 3 sec",
    );
    expect(
      Duration(days: 1, minutes: 3, seconds: 3).string(),
      "1 d 3 min 3 sec",
    );
    expect(
      Duration(days: 1, hours: 24, minutes: 3, seconds: 3).string(),
      "2 d 3 min 3 sec",
    );
    expect(
      Duration(days: 1, seconds: 3).string(),
      "1 d 3 sec",
    );
    expect(1.microseconds.string(), "<0 sec");
    expect(1.milliseconds.string(), "<0 sec");
    expect(Duration.zero.string(), "0 sec");
  });

  test('should DateTimeRange.format()', () {
    expect(
      DateTime(1984, 11, 19).rangeTo(DateTime(1984, 11, 28)).format(),
      "November 19 - 28",
    );
    expect(
      DateTime(1984, 11, 19).rangeTo(DateTime(1983, 11, 28)).format(),
      "Nov 19, 1984 - Nov 28, 1983",
    );

    expect(
      DateTime(1984, 11, 19).rangeTo(DateTime(1984, 12, 2)).format(),
      "Nov 19 - Dec 2",
    );
    expect(
      DateTime(1984, 11, 19).rangeTo(DateTime(2020, 1, 2)).format(),
      "Nov 19, 1984 - Jan 2, 2020",
    );

    expect(
      DateTime(1984, 11, 19, 11, 59, 59).rangeTo(DateTime(1984, 11, 19, 12, 59, 59)).format(),
      //"Mon, 11/19 11:59 AM - 12:59 PM",
      "Mon 11:59 AM - 12:59 PM",
    );
    expect(
    DateTime(1984, 11, 19).rangeTo(DateTime(1985, 11, 23)).format(),
      "Nov 19, 1984 - Nov 23, 1985",
    );
  });

}
