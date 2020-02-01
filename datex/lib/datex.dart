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
  static DateTime today({DateTime from, int offsetDays = 0}) {
    from ??= DateTime.now();
    return DateTime(from.year, from.month, from.day + offsetDays);
  }

  ///  5671234567
  ///      ^
  ///   ^      ^
  ///  -3     +5
  /// final lastSat
  /// final nextSat
  static DateTime lastWeekday(weekday, {DateTime from}) {
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
  static DateTime nextWeekday(weekday, {DateTime from}) {
    from = from ?? DateTime.now();
    return today(from: from, offsetDays: (from.weekday + (7 - weekday)) + 1);
  }

  static DateTime recentWeekday(weekday, {DateTime from}) {
    from = from ?? DateTime.now();
    if (weekday == from.weekday) return today(from: from);
    return from.weekday < weekday ? today(from: from, offsetDays: -7 + (weekday - from.weekday)) : today(from: from, offsetDays: weekday - from.weekday);
  }

  // TODO
  static DateTime thisWeekday(weekday, {DateTime from, int startDay = 6}) {
    //0123456
    //  ^
    //6012345
    //
    //0 + startDay % 7

    //2 + 6 % 7 = 1
    //weekday + startDay % 7;
    //6 + 6 % 7 = 5
    //if (startDay + 7 < from.weekday + 7)
    return today(from: from, offsetDays: weekday < from.weekday ? lastWeekday(weekday) : from.weekday - weekday);
  }

  static DateTime of(String text, {bool isUtc = false}) => text?.toUtcOrNull()?.toLocal() ?? text?.toDateTimeOrNull() ?? DateTime.now();
  //static DateTime ofNull(String text, {bool isUtc = false}) => or(() => DateTime.parse("${text}${isUtc ? "Z" : ""}"));

  static DateTime fromSeconds(int seconds, {bool isUtc = false}) => fromDuration(Duration(seconds: seconds), isUtc: isUtc);
  static DateTime fromDuration(Duration duration, {bool isUtc = false}) => DateTime.fromMicrosecondsSinceEpoch(duration.inMicroseconds, isUtc: isUtc);
  static int secondsSinceEpoch(DateTime date) => date.millisecondsSinceEpoch ~/ 1000;

  static String formatAgo(DateTime since) {
    // TODO
    return null;
  }

  static String formatDuration(Duration duration) {
    // TODO
    return null;
  }

  static DateTime _zero = DateTime(0);
  static DateTime get zero => _zero;
}

extension SimpleDateTimeX<T extends DateTime> on T {
  // 1 AM -1d
  String haFrom({DateTime since}) {
    since ??= DateTime.now();
    final days = difference(since).inDays;
    final haFormat = DateFormat("ha");
    final formatted = haFormat.format(this);
    final formattedDays = days.isNegative ? "${days}d" : "+${days}d";

    return (days == 0) ? formatted : "${formatted} ${formattedDays}";
  }

  DateTimeRange range(Duration range, {Duration step = const Duration(hours: 1)}) {
    final until = this + range;
    return rangeTo(until, step: step);
  }

  DateTimeRange rangeTo(DateTime endInclusive, {Duration step = const Duration(hours: 1)}) =>
       DateTimeRange(this, endInclusive, step: step);

  DateTimeProgression downTo(DateTime endInclusive, {Duration step = const Duration(hours: 1)}) =>
      DateTimeProgression(this, endInclusive, step: step);
}

//class DateTimeRange extends DateTimeProgression implements ClosedRange<DateTime> {
class DateTimeRange extends DateTimeProgression {
  /// Creates a range between two ints ([first], [endInclusive]) which can be
  /// iterated through.
  ///
  /// [step] (optional, defaults to Duration(hours: 1)) has to be positive even when iterating
  /// downwards.
  DateTimeRange(DateTime first, DateTime endInclusive, {Duration step = const Duration(hours: 1)})
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
        }()), super(first, endInclusive, step: step);

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
  DateTimeProgression(DateTime first, DateTime endInclusive, {Duration step = const Duration(hours: 1)})
      : _first = first,
  // can't initialize directly du to naming conflict with step() method
  // ignore: prefer_initializing_formals
        stepSize = step,
        _last = _getDateTimeProgressionLastElement(first, endInclusive, step),
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

  @override
  Iterator<DateTime> get iterator => _DateTimeRangeIterator(_first, _last, stepSize);

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
  _DateTimeRangeIterator(this.first, this.last, this.step);

  final DateTime first;
  final DateTime last;
  final Duration step;

  @override
  DateTime get current => _current;
  DateTime _current;
  bool completed = false;

  @override
  bool moveNext() {
    if (completed) return false;

    if (first == last) {
      completed = true;
      return false;
    }

    final now = _current ?? first;
    var next = now;
    if (_current != null) {
      assert(first != last);
      if (first <= last) {
        next += step;
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

extension DateTimeStringX<T extends String> on T {
  DateTime toDateTime() => DateTime.parse(this);
  DateTime toDateTimeOrNull() => DateTime.tryParse(this);
  DateTime toUtc() => suffix('Z').toDateTime();
  DateTime toUtcOrNull() => suffix('Z').toDateTimeOrNull();
  String suffix(String suffix) => endsWith(suffix) ? this : "${this}${suffix}";
}

extension DurationX<T extends Duration> on T {
  String ms() => Durations.ms(this);
  String hms() => Durations.hms(this);

  static const daysPerYear = 365;

  String string({
    String separator: " ",
    String seconds: " sec.",
    String minutes: " min.",
    String hours: " h",
    String days: " d",
    String years: " y",
  }) {
    final int nYears = inDays ~/ daysPerYear;
    final int nDays = inDays.remainder(daysPerYear);
    final int nHours = inHours.remainder(Duration.hoursPerDay);
    final int nMinutes = inMinutes.remainder(Duration.minutesPerHour);
    final int nSeconds = inSeconds.remainder(Duration.secondsPerMinute);
    
    final List<String> res = [];
    
    if (nSeconds >= 0) {
      res.add("${nSeconds}${seconds}");
    }
    if (nMinutes > 0) {
      res.add("${nMinutes}${minutes}");
    }
    if (nHours > 0) {
      res.add("${nHours}${hours}");
    }
    if (nDays > 0) {
      res.add("${nDays}${days}");
    }
    if (nYears > 0) {
      res.add("${nYears}${years}");
    }

    if (res.isEmpty) {
      return "<0${seconds}";
    }

    return res.reversed.joinToString(separator: separator).trim();
  }

  DateTime agoOf(DateTime since) => (since ?? DateTime.now()) - this;
}

class Durations {
  //DateFormat.ms().format(DateFormat.ms().parse("00:00").add(Duration(seconds: 60) - Duration(seconds: t.tick))),
  static String ms(Duration duration) {
    final text = "${duration.inMinutes.remainder(60).abs()}:${NumberFormat("00").format(duration.inSeconds.remainder(60).abs())}";
    return duration.isNegative ? "-${text}" : text;
  }
  static String hms(Duration duration) {
    final text = "${duration.inHours.abs()}:${duration.inMinutes.remainder(60).abs()}:${duration.inSeconds.remainder(60).abs()}";
    return duration.isNegative ? "-${text}" : text;
  }
}

extension DateTimeAgo<T extends DateTime> on T {
  //String ago({
  //  String locale,
  //  DateTime until,
  //  bool allowFromNow = true,
  //}) => timeago.format(this, until: until, allowFromNow: allowFromNow);

  String agoString({DateTime since}) {
    since ??= DateTime.now();
    return (since.difference(this)).agoString(since: since);
  }
}

extension DurationAgoX<T extends Duration> on T {
  String agoString({DateTime since}) {
    final duration = this;
    if (duration.inMinutes < 1) {
      final seconds = duration.inSeconds.remainder(60).round();
      if (seconds == 0) {
        return null;
      } else {
        return "${duration.inSeconds.remainder(60).round()}s ago";
      }
    } else if (duration.inHours < 1) {
      final seconds = duration.inSeconds.remainder(60).round();
      if (seconds == 0) {
        return "${duration.inMinutes.remainder(60).round()} mins ago";
      } else {
        return "${duration.inMinutes.remainder(60).round()} mins ${seconds} s ago";
      }
    } else if (duration.inHours < 3) { // >= 1hours
      final minutes = duration.inMinutes.remainder(60).round();
      if (minutes == 0) {
        return "${duration.inHours.remainder(24).round()} hrs ago";
      } else {
        return "${duration.inHours.remainder(24).round()} hrs ${minutes} mins ago";
      }
    } else if (duration.inDays <= 1 && since != null) {
      if (since.isAfter(DateTimes.today())) {
        return "Today, at ${DateFormat.jm().format(since).toLowerCase()}";
      } else {
        return "Yesterday, at ${DateFormat.jm().format(since).toLowerCase()}";
      }
    } else {
      if (since != null) {
        return "${DateFormat.MMMMd().format(since)} at ${DateFormat.jm().format(since).toLowerCase()}";
      } else {
        return null;
      }
    }
  }
}
