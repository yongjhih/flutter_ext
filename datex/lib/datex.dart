library datex;

import 'dart:collection';

import 'package:intl/intl.dart';
import 'package:dartx/dartx.dart';
import 'package:time/time.dart';

class DateTimes {
  static DateTime hour(DateTime from) {
    return DateTime(from.year, from.month, from.day, from.hour);
  }

  static List<DateTime> hours(DateTime from) {
    return List.generate(24, (i) => DateTime(from.year, from.month, from.day, i));
  }

  static List<DateTime> weekdays(DateTime from) {
    return List.generate(7, (i) => DateTime(from.year, from.month, from.day + i));
  }

  /// original today
  static DateTime today({DateTime? from, int offsetDays = 0}) {
    from ??= DateTime.now();
    return DateTime(from.year, from.month, from.day + offsetDays);
  }

  ///  5671234567
  ///      ^
  ///   ^      ^
  ///  -3     +5
  /// final lastSat
  /// final nextSat
  static DateTime lastWeekday(weekday, {DateTime? from}) {
    from ??= DateTime.now();
    if (weekday < from.weekday) return today(from: from, offsetDays: weekday - from.weekday);
    return today(from: from, offsetDays: weekday - (from.weekday + 7));
  }

  ///  5671234567
  ///      ^
  ///   ^      ^
  ///  -3     +5
  /// final lastSat
  /// final nextSat
  static DateTime nextWeekday(int weekday, {DateTime? from}) {
    from = from ?? DateTime.now();
    return today(from: from, offsetDays: (from.weekday + (7 - weekday)) + 1);
  }

  static DateTime recentWeekday(int weekday, {DateTime? from}) {
    from = from ?? DateTime.now();
    if (weekday == from.weekday) return today(from: from);
    return from.weekday < weekday
        ? today(from: from, offsetDays: -7 + (weekday - from.weekday))
        : today(from: from, offsetDays: weekday - from.weekday);
  }

  // TODO
  static DateTime thisWeekday(int weekday, {DateTime? from, int startDay = 6}) {
    from ??= DateTime.now();
    //0123456
    //  ^
    //6012345
    //
    //0 + startDay % 7

    //2 + 6 % 7 = 1
    //weekday + startDay % 7;
    //6 + 6 % 7 = 5
    //if (startDay + 7 < from.weekday + 7)
    final n = (weekday < from.weekday)
        ? (lastWeekday(weekday, from: from)).weekday
        : from.weekday - weekday;
    return today(
        from: from,
        offsetDays: n,
    );
  }

  static DateTime of(String text, {bool isUtc = false}) => text.toUtcOrNull()?.toLocal() ?? text.toDateTimeOrNull() ?? DateTime.now();
  //static DateTime ofNull(String text, {bool isUtc = false}) => or(() => DateTime.parse("${text}${isUtc ? "Z" : ""}"));

  static DateTime fromSeconds(int seconds, {bool isUtc = false}) => fromDuration(Duration(seconds: seconds), isUtc: isUtc);
  static DateTime fromDuration(Duration duration, {bool isUtc = false}) => DateTime.fromMicrosecondsSinceEpoch(duration.inMicroseconds, isUtc: isUtc);
  static int secondsSinceEpoch(DateTime date) => date.millisecondsSinceEpoch ~/ 1000;

  static String? formatAgo(DateTime since) {
    // TODO
    return null;
  }

  static String? formatDuration(Duration duration) {
    // TODO
    return null;
  }

  static DateTime _zero = DateTime(0);
  static DateTime get zero => _zero;
}

extension DateTimeStringX<T extends String> on T {
  DateTime toDateTime() => DateTime.parse(this);
  DateTime? toDateTimeOrNull() => DateTime.tryParse(this);
  DateTime toUtc() => suffix('Z').toDateTime();
  DateTime? toUtcOrNull() => suffix('Z').toDateTimeOrNull();
  String suffix(String suffix) => endsWith(suffix) ? this : "${this}${suffix}";
}

extension DateTimeX<T extends DateTime> on T {

  DateTimeRange range(Duration range, {Duration step = const Duration(hours: 1)}) {
    final until = this + range;
    return rangeTo(until, step: step);
  }

  DateTimeRange rangeTo(DateTime endInclusive, {
    Duration step = const Duration(hours: 1),
    bool leap = true,
  }) =>
       DateTimeRange(this, endInclusive, step: step, leap: leap);

  DateTimeProgression downTo(DateTime endInclusive, {
    Duration step = const Duration(hours: 1),
    bool leap = true,
  }) =>
      DateTimeProgression(this, endInclusive, step: step, leap: leap);

  String format(DateFormat format) => format.format(this);

  String? formatOrNull(DateFormat format) => format.formatOrNull(this);

  /// Last day of this month
  DateTime lastDay() => nextMonths().copyWith(day: 0);

  DateTime lastDaySecond() => nextMonths().copyWith(
    day: 1,
    hour: 0,
    minute: 0,
    second: -1,
    millisecond: 0,
    microsecond: 0,
  );

  /// Last day moment of this month
  ///
  /// Equivalent to first day moment of next month - 1 microsecond
  DateTime lastDayMoment() => nextMonths().copyWith(
    day: 1,
    hour: 0,
    minute: 0,
    second: 0,
    millisecond: 0,
    microsecond: -1,
  );

  DateTime firstDay() => copyWith(day: 1);

  /// First day moment of this month
  DateTime firstDayMoment() => copyWith(
    day: 1,
    hour: 0,
    minute: 0,
    second: 0,
    millisecond: 0,
    microsecond: 0,
  );

  /// Last moment today
  ///
  /// Equivalent to tomorrow first moment - 1 microsecond
  DateTime lastMoment() => copyWith(
    day: day + 1,
    hour: 0,
    minute: 0,
    second: 0,
    millisecond: 0,
    microsecond: -1,
  );

  /// First moment today
  DateTime firstMoment() => copyWith(
    hour: 0,
    minute: 0,
    second: 0,
    millisecond: 0,
    microsecond: 0,
  );

  /// 1234567
  ///       ^
  DateTime firstWeekday([int? end]) => copyWith(
    day: day - (DurationX.daysPerWeek) + 1,
  );

  DateTime firstWeekdayMoment([int? end]) => copyWith(
    day: day - (DurationX.daysPerWeek) + 1,
    hour: 0,
    minute: 0,
    second: 0,
    millisecond: 0,
    microsecond: 0,
  );

  /// TODO end weekday
  DateTime lastWeekday([int? end]) => copyWith(
    day: day + (DurationX.daysPerWeek) - 1,
  );

  /// TODO end weekday
  DateTime lastWeekdayMoment([int? end]) => copyWith(
    day: day + (DurationX.daysPerWeek),
    hour: 0,
    minute: 0,
    second: 0,
    millisecond: 0,
    microsecond: -1,
  );

  DateTime firstMomentOfYear() => copyWith(
    year: year,
    month: 1,
    day: 1,
    hour: 0,
    minute: 0,
    second: 0,
    millisecond: 0,
    microsecond: 0,
  );

  DateTime lastMomentOfYear() => copyWith(
    year: year + 1,
    month: 1,
    day: 1,
    hour: 0,
    minute: 0,
    second: 0,
    millisecond: 0,
    microsecond: -1,
  );

  DateTime get atFirstDayOfYear => copyWith(
    year: year,
    month: 1,
    day: 1,
  );

  DateTime get atLastDayOfYear => copyWith(
    year: year + 1,
    month: 1,
    day: 0,
  );

  /// expect(3/31.monthAgo(), 2/29)
  DateTime monthsAgo([int months = 1]) => copyWith(month: month - months).coerceAtMost(copyWith(month: month - months + 1, day: 0));
  /// expect(1/31.nextMonth(), 2/29)
  DateTime nextMonths([int months = 1]) => copyWith(month: month + months).coerceAtMost(copyWith(month: month + months + 1, day: 0));

  DateTime yearsAgo([int years = 1]) => copyWith(year: year - years);
  DateTime nextYears([int years = 1]) => copyWith(year: year + years);

  DateTime weeksAgo([int weeks = 1]) => copyWith(day: day - (weeks * DurationX.daysPerWeek));
  DateTime nextWeeks([int weeks = 1]) => copyWith(day: day + (weeks * DurationX.daysPerWeek));

  DateTime yesterday() => daysAgo();
  DateTime tomorrow() => nextDays();

  DateTime daysAgo([int days = 1]) => copyWith(day: day - days);

  DateTime nextDays([int days = 1]) => copyWith(day: day + days);

  DateTimeRange hours({ bool inclusive = true }) => inclusive
      ? firstMoment().rangeTo(tomorrow().firstMoment(), step: 1.hours)
      : firstMoment().rangeTo(lastMoment(), step: 1.hours);

  /// 1234567
  /// ^
  DateTimeRange weekdays({ bool inclusive = true }) => inclusive
      ? firstMoment().rangeTo(nextWeeks().firstMoment(), step: 1.days)
      : firstMoment().rangeTo(lastWeekdayMoment(), step: 1.days);

//DateTimeRange get days => firstDayMoment().rangeTo(nextMonths().firstDayMoment(), step: 1.days);

}

//class DateTimeRange extends DateTimeProgression implements ClosedRange<DateTime> {
class DateTimeRange extends DateTimeProgression {
  /// Creates a range between two ints ([first], [endInclusive]) which can be
  /// iterated through.
  ///
  /// [step] (optional, defaults to Duration(hours: 1)) has to be positive even when iterating
  /// downwards.
  DateTimeRange(DateTime first, DateTime endInclusive, {
    Duration step = const Duration(hours: 1),
    bool leap = true,
  })
      : _first = first,
        // can't initialize directly du to naming conflict with step() method
        // ignore: prefer_initializing_formals
        stepSize = step,
        _last = endInclusive,
        assert(() {
          if (first == null) throw ArgumentError("start can't be null");
          if (endInclusive == null) {
            throw ArgumentError("endInclusive can't be null");
          }
          if (step == null) throw ArgumentError("step can't be null");
          return true;
        }()), super(first, endInclusive, step: step, leap: leap);

  /// The first element in the range.
  final DateTime _first;

  /// The last element in the range.
  final DateTime _last;

  /// The step of the range.
  final Duration stepSize;

  @override
  DateTime get endInclusive => _last;

  @override
  DateTime get start => _first;

  @override
  String toString() => '$start..$endInclusive';

  @override
  bool get isEmpty => !(start <= endInclusive);

  /*
  @override
  bool operator ==(Object other) =>
      (other is ClosedRange) && (isEmpty && other.isEmpty ||
          start == other.start && endInclusive == other.endInclusive);
  */

  @override
  int get hashCode =>
      isEmpty ? -1 : 31 * start.hashCode + endInclusive.hashCode;
}

class DateTimeProgression extends IterableBase<DateTime> {
  /// Creates a range between two ints ([first], [endInclusive]) which can be
  /// iterated through.
  ///
  /// [step] (optional, defaults to Duration(hours: 1)) has to be positive even when iterating
  /// downwards.
  DateTimeProgression(DateTime first, DateTime endInclusive, {
    Duration step = const Duration(hours: 1),
    this.leap = true,
  })
      : _first = first,
  // can't initialize directly du to naming conflict with step() method
  // ignore: prefer_initializing_formals
        stepSize = step,
        _last = !leap ? _getDateTimeProgressionLastElement(first, endInclusive, step) : endInclusive,
        assert(() {
          if (first == null) throw ArgumentError("start can't be null");
          if (endInclusive == null) {
            throw ArgumentError("endInclusive can't be null");
          }
          if (step == null) throw ArgumentError("step can't be null");
          return true;
        }());

  /// The first element in the range.
  final DateTime _first;

  /// The last element in the range.
  final DateTime _last;

  /// The step of the range.
  final Duration stepSize;

  final bool leap;

  @override
  Iterator<DateTime> get iterator => _DateTimeRangeIterator(
      first: _first,
      last: _last,
      step: stepSize,
      leap: leap,
  );

  DateTime get endInclusive => _last;

  DateTime get start => _first;

  @override
  String toString() => '$start..$endInclusive';
}

DateTime _getDateTimeProgressionLastElement(DateTime start, DateTime end, Duration step) {
  if (step <= Duration.zero) {
    throw RangeError.range(step.inSeconds, 1, null);
  }
  if (start >= end) {
    return end;
  } else {
    return end - Duration(milliseconds: _differenceModulo(end.millisecondsSinceEpoch, start.millisecondsSinceEpoch, step.inMilliseconds));
  }
}

// (a - b) mod c
int _differenceModulo(int a, int b, int c) {
  return _mod(_mod(a, c) - _mod(b, c), c);
}

int _mod(int a, int b) {
  final mod = a % b;
  if (mod >= 0) {
    return mod;
  } else {
    return mod + b;
  }
}

class _DateTimeRangeIterator extends Iterator<DateTime> {
  _DateTimeRangeIterator({
      required this.first,
      required this.last,
      required this.step,
      required this.leap,
  });

  final DateTime first;
  final DateTime last;
  final Duration step;
  final bool leap;

  @override
  DateTime get current => _current ?? first;
  DateTime? _current;
  bool completed = false;

  @override
  bool moveNext() {
    if (completed) return false;

    if (first == last) {
      completed = true;
      return false;
    }

    if (_current == null) {
      _current = first;
      return true;
    }

    final now = _current ?? first;
    DateTime next = now;
      assert(first != last);
      if (first <= last) {
        if (leap) {
          next = next.copyWith(
            year: next.year + step.years(),
            month: next.month + step.months(),
            day: next.day + step.days(),
            hour: next.hour + step.hours(),
            minute: next.minute + step.minutes(),
            second: next.second + step.seconds(),
            millisecond: next.second + step.milliseconds(),
            microsecond: next.second + step.microseconds(),
          );
        } else {
          next += step;
        }
      } else {
        if (leap) {
          next = next.copyWith(
            year: next.year - step.years(),
            month: next.month - step.months(),
            day: next.day - step.days(),
            hour: next.hour - step.hours(),
            minute: next.minute - step.minutes(),
            second: next.second - step.seconds(),
            millisecond: next.second - step.milliseconds(),
            microsecond: next.second - step.microseconds(),
          );
        } else {
          next -= step;
        }
      }
    // exit when beyond end
    if (first <= last) {
      if (next > last) {
        _current = null;
        completed = true;
        return false;
      }
    } else {
      if (next < last) {
        _current = null;
        completed = true;
        return false;
      }
    }

    _current = next;
    return true;
  }
}

extension DateFormatX<T extends DateFormat> on T {
  String? tryFormat(DateTime date) => formatOrNull(date);

  String? formatOrNull(DateTime date) {
    try {
      return format(date);
    } on FormatException {
      return null;
    }
  }
}

extension DateTimeRangeX<T extends DateTimeRange> on T {
  String format({
    String spacer = " - ",
    DateFormat? yearFormat,
    DateFormat? monthFormat,
    DateFormat? dayFormat,
    DateFormat? dayTimeFormat,
    DateFormat? timeFormat,
    DateFormat add(DateFormat format)?,
  }) {
    yearFormat ??= DateFormat.yMMMd();
    monthFormat ??= DateFormat.MMMd();
    dayFormat ??= DateFormat.MMMM();
    dayTimeFormat ??= DateFormat.E(); // DateFormat.MEd();
    timeFormat ??= DateFormat.jm();
    add ??= (it) => it;
    if (start.year != endInclusive.year) {
      return "${start.format(yearFormat)}${spacer}${endInclusive.format(yearFormat)}";
    } else if (start.month != endInclusive.month) {
      return "${start.format(monthFormat)}${spacer}${endInclusive.format(add(monthFormat))}";
    } else {
      if (start.day != endInclusive.day) {
        return "${start.format(dayFormat)} ${start.format(DateFormat.d())}${spacer}${endInclusive.format(add(DateFormat.d()))}";
      } else {
        return "${start.format(dayTimeFormat)} ${start.format(timeFormat)}${spacer}${endInclusive.format(add(timeFormat))}";
      }
    }
  }
}

extension DurationX<T extends Duration> on T {
  String ms() {
    final text = "${minutes().abs()}:${NumberFormat("00").format(seconds().abs())}";
    return isNegative ? "-${text}" : text;
  }
  String hms() {
    final text = "${inHours.abs()}:${minutes().abs()}:${seconds().abs()}";
    return isNegative ? "-${text}" : text;
  }

  static const daysPerYear = 365;
  static const daysPerWeek = 7;
  static const daysPerMonth = 30;

  int years() => inDays ~/ daysPerYear;
  int months() => inDays.remainder(daysPerYear) ~/ daysPerMonth;
  int days() => inDays.remainder(daysPerYear).remainder(daysPerMonth).round();
  int hours() => inHours.remainder(Duration.hoursPerDay).round();
  int minutes() => inMinutes.remainder(Duration.minutesPerHour).round();
  int seconds() => inSeconds.remainder(Duration.secondsPerMinute).round();
  int milliseconds() => inMilliseconds.remainder(Duration.millisecondsPerSecond).round();
  int microseconds() => inMicroseconds.remainder(Duration.microsecondsPerMillisecond).round();

  /// See also https://github.com/desktop-dart/duration/blob/master/lib/src/duration.dart
  String string({
    bool single = false,
    String separator = " ",
    String second(int n)?,
    String seconds(int n)?,
    String minute(int n)?,
    String minutes(int n)?,
    String hours(int n)?,
    String hour(int n)?,
    String days(int n)?,
    String day(int n)?,
    String years(int n)?,
    String year(int n)?,
  }) {
    second ??= (n) => "${n} sec";
    seconds ??= (n) => "${n} sec";
    minute ??= (n) => "${n} min";
    minutes ??= (n) => "${n} min";
    hour ??= (n) => "${n} h";
    hours ??= (n) => "${n} h";
    day ??= (n) => "${n} d";
    days ??= (n) => "${n} d";
    year ??= (n) => "${n} y";
    years ??= (n) => "${n} y";

    final int nYears = this.years();
    final int nDays = this.days();
    final int nHours = this.hours();
    final int nMinutes = this.minutes();
    final int nSeconds = this.seconds();

    final List<String> res = [];

    if (this == Duration.zero) {
      return "${second(nSeconds)}";
    }

    if (nSeconds > 0) {
      if (nSeconds == 1) {
        res.add("${second(nSeconds)}");
      } else {
        res.add("${seconds(nSeconds)}");
      }
    }
    if (nMinutes > 0) {
      if (nMinutes == 1) {
        res.add("${minute(nMinutes)}");
      } else {
        res.add("${minutes(nMinutes)}");
      }
    }
    if (nHours > 0) {
      if (nHours == 1) {
        res.add("${hour(nHours)}");
      } else {
        res.add("${hours(nHours)}");
      }
    }
    if (nDays > 0) {
      if (nDays == 1) {
        res.add("${day(nDays)}");
      } else {
        res.add("${days(nDays)}");
      }
    }
    if (nYears > 0) {
      if (nYears == 1) {
        res.add("${year(nYears)}");
      } else {
        res.add("${years(nYears)}");
      }
    }

    if (res.isEmpty) {
      return "<${second(0)}";
    }

    if (single) {
      return res.last;
    }

    return res.reversed.joinToString(separator: separator).trim();
  }

  DateTime agoOf(DateTime? since) => (since ?? DateTime.now()) - this;
}