//Set up for result pattern

typedef FailureHandler<T> = T Function(Object? error, StackTrace? st);
typedef OkHandler<TReturn, TValue> = TReturn Function(TValue value);

sealed class Result<T extends Object?> {
  const Result();

  ///Wether or not this result is [Ok].
  bool get isOk;

  ///Wether or not this result is [Failure]
  bool get isFailure;

  ///Force this result to be [Ok], will throw if it is not [Ok].
  Ok<T> get asOk;

  ///Force this result to be [Failure], will throw if it is not [Failure]
  Failure get asFailure;

  ///Require the value of Ok, will throw if [Result] was not [Ok].
  T get require;

  ///Get the value or throw the stored error. Not recommended since the stored stackTrace will be lost.
  T getOrThrow();

  ///Get the value or return one from a [FailureHandler].
  T getOrElse(FailureHandler<T> onFailure);

  ///Get the value or the supplied default value.
  T getOrDefault(T value);

  ///Get the value or return null
  T? getOrNull();

  ///Map the value of [Result] to a new one.
  Result<U> map<U extends Object?>(OkHandler<U, T> fn);

  ///Map the value of [Result] with a function that also returns [Result];
  Result<U> flatMap<U extends Object?>(OkHandler<Result<U>, T> fn);

  ///Change the [Ok] value
  Result<U> pure<U extends Object?>(U value);

  ///Change the [Failure] value
  Result<U> failure<U extends Object?>(Object error, {StackTrace? stackTrace});

  ///Fold [Result] back to a single value. Can be seen as a declarative switch Statement;
  U fold<U>({
    required OkHandler<U, T> onOk,
    required FailureHandler<U> onFailure,
  });
}

final class Ok<T extends Object?> extends Result<T> {
  final T value;

  const Ok(this.value);

  @override
  bool get isFailure => false;

  @override
  bool get isOk => true;

  @override
  Failure get asFailure => throw AssertionError("Result was not of type [Ok]");

  @override
  Ok<T> get asOk => this;

  @override
  T get require => value;

  @override
  T getOrThrow() => value;

  @override
  T getOrElse(FailureHandler<T> onFailure) => value;

  @override
  T getOrDefault(T value) => this.value;

  @override
  T? getOrNull() => value;

  @override
  Result<U> map<U extends Object?>(OkHandler<U, T> fn) => Ok(fn(value));

  @override
  Result<U> flatMap<U extends Object?>(OkHandler<Result<U>, T> fn) => fn(value);

  @override
  Result<U> pure<U extends Object?>(U value) => Ok(value);

  @override
  Result<U> failure<U extends Object?>(
    Object error, {
    StackTrace? stackTrace,
  }) => Failure(error, stackTrace);

  @override
  U fold<U>({
    required OkHandler<U, T> onOk,
    required FailureHandler<U> onFailure,
  }) => onOk(value);
}

final class Failure<T extends Object?> implements Result<T> {
  final Object error;
  final StackTrace? stackTrace;

  const Failure(this.error, [this.stackTrace]);

  @override
  bool get isFailure => true;

  @override
  bool get isOk => false;

  @override
  Failure get asFailure => this;

  @override
  Ok<T> get asOk => throw AssertionError("Result was not of type [Ok]");

  @override
  T get require => throw AssertionError("Result was not of type [Ok]");

  @override
  T getOrThrow() => stackTrace == null
      ? throw error
      : Error.throwWithStackTrace(error, stackTrace!);

  @override
  T getOrElse(FailureHandler<T> onFailure) => onFailure(error, stackTrace);

  @override
  T getOrDefault(T value) => value;

  @override
  T? getOrNull() => null;

  @override
  Result<U> map<U extends Object?>(OkHandler<U, T> fn) =>
      failure(error, stackTrace: stackTrace);

  @override
  Result<U> flatMap<U extends Object?>(OkHandler<Result<U>, T> fn) =>
      failure(error, stackTrace: stackTrace);

  @override
  Result<U> pure<U extends Object?>(U value) => Ok(value);

  @override
  Result<U> failure<U extends Object?>(
    Object error, {
    StackTrace? stackTrace,
  }) => Failure(error, stackTrace);

  @override
  U fold<U>({
    required OkHandler<U, T> onOk,
    required FailureHandler<U> onFailure,
  }) => onFailure(error, stackTrace);
}
