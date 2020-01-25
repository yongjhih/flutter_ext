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

## Installation

```yml
  flutter_dtx:
    git:
      url: https://github.com/yongjhih/flutter_dtx.git
      path: flutter_dtx
  provider_dtx:
    git:
      url: https://github.com/yongjhih/flutter_dtx.git
      path: provider_dtx
  streamx:
    git:
      url: https://github.com/yongjhih/flutter_dtx.git
      path: streamx
```

## See Also


* [dartx](https://github.com/leisim/dartx)
* [time.dart](https://github.com/jogboms/time.dart)
* [dart-kotlin_flavor](https://github.com/YusukeIwaki/dart-kotlin_flavor)
