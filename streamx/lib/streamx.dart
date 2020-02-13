library streamx;

import 'dart:async';

extension StreamX<T> on Stream<T> {
  Stream<T> distinctBy<R>(R comsume(T it)) =>
    distinct((prev, next) => comsume(prev) == comsume(next));

  Future<T> firstOrNull() async =>
    firstWhere((it) => true, orElse: () => null);
}

extension IterableStreamX<T> on Iterable<T> {
  Stream<T> asStream() => Stream.fromIterable(this);
}

extension IterableFutureStreamX<T> on Iterable<Future<T>> {
  Stream<T> asStream() => Stream.fromFutures(this);
}

extension FutureStreamX<T> on Future<T> {
  Stream<T> asStream() => Stream.fromFuture(this);
}

typedef _Callable<R> = R Function();

extension CallableStreamX<T> on _Callable<T> {
  Stream<T> asStream() => _CallableStream(this);
}

class _CallableStream<T> extends Stream<T> {
  _CallableStream(_Callable<T> callable)
      : _factory = (() {
          try {
            return Stream.value(callable());
          } catch (e) {
            return Stream.error(e);
          }
        });

  final Stream<T> Function() _factory;

  @override
  bool get isBroadcast => true;

  @override
  StreamSubscription<T> listen(void onData(T event),
          {Function onError, void onDone(), bool cancelOnError}) =>
      _factory().listen(onData,
          onError: onError, onDone: onDone, cancelOnError: cancelOnError);
}

typedef _FutureCallable<R> = Future<R> Function();

extension FutureCallableStreamX<T> on _FutureCallable<T> {
  Stream<T> asStream() => _FutureCallableStream(this);
}

class _FutureCallableStream<T> extends Stream<T> {
  _FutureCallableStream(_FutureCallable<T> callable)
      : _factory = (() {
          try {
            return Stream.fromFuture(callable());
          } catch (e) {
            return Stream.error(e);
          }
        });

  final Stream<T> Function() _factory;

  @override
  bool get isBroadcast => true;


  @override
  StreamSubscription<T> listen(void onData(T event),
          {Function onError, void onDone(), bool cancelOnError}) =>
      _factory().listen(onData,
          onError: onError, onDone: onDone, cancelOnError: cancelOnError);
}

/// TODO
extension CallablesStreamX<R> on Iterable<_Callable<R>> {
  Stream<R> asStream() => null;
}

/// TODO
extension FutureCallablesStreamX<R> on Iterable<_FutureCallable<R>> {
  Stream<R> asStream() => null;
}

/// TODO
extension StreamsX<T> on Iterable<Stream<T>> {
  Stream<T> asStream() => null;
}