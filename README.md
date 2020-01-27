## Usage

Before:
```dart
Text("Title", style: Theme.of(context).textTheme.title);
```
After:

```dart
Text("Title", style: context.theme().textTheme.title);
```

Before:

```dart
Navigator.of(context).pop();
```

After:

```dart
context.navigator().pop();
```


Before:

```dart
final username = Provider.of<UsernameNotifier>(context, listen: false).value;
```

After:

```dart
final username = context.provider<UsernameNotifier>(listen: false).value;
```


Before:

```dart
expect(
  await Stream.fromIterable(["123", "abc"])
    .distinct((prev, next) => prev.length == next.length)
    .last,
  "123"
);
```

After:

```dart
expect(
  await Stream.fromIterable(["123", "abc"])
    .distinctBy((it) => it.length)
    .last,
   "123"
);
```

Before:

```dart
expect(1, isNotNull);
expect([], isEmpty);
expect([], []);
expect(1, isIn([1, 2, 3]));
expect(0, predicate((x) => ((x % 2) == 0), "is even"))

final list0 = [];
expect(list0, same(list0));
```

After:

```dart
isNotNull.of(1);
isNull.of(null);
isEmpty.of([]);
equals([]).of([]);
[1, 2, 3].isHaving(1); // isIn([1, 2, 3]).of(1)
predicate((x) => ((x % 2) == 0), "is even").of(0);

final list0 = [];
same(list0).of(list0);
```

## Installation

```yml
  flutter_ext:
    git:
      url: https://github.com/yongjhih/flutter_ext.git
      path: flutter_dtx
  providerx:
    git:
      url: https://github.com/yongjhih/flutter_ext.git
      path: provider_dtx
  streamx:
    git:
      url: https://github.com/yongjhih/flutter_ext.git
      path: streamx
  test_ext:
    git:
      url: https://github.com/yongjhih/flutter_ext.git
      path: test_ext
```

## See Also


* [dartx](https://github.com/leisim/dartx)
* [time.dart](https://github.com/jogboms/time.dart)
* [dart-kotlin_flavor](https://github.com/YusukeIwaki/dart-kotlin_flavor)
