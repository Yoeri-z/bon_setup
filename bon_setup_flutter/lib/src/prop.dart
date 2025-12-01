import 'package:bon_setup/bon_setup.dart';

///A simple property that can be contained and managed by a change notifier.
///
///This property is not listenable, listenability should still be managed by the class containing the prop.
///
///This is done to keep maximum compatibility with Provider, rebuilds can be filtered for specific props by context.select if need be.
class Prop<T> {
  Result<T>? _result;

  ///A simple property that can be contained and managed by a change notifier.
  ///
  ///This property is not listenable, listenability should still be managed by the class containing the prop.
  ///
  ///This is done to keep maximum compatibility with Provider, rebuilds can be filtered for specific props by context.select if need be.
  Prop([T? initialValue]) {
    if (initialValue != null) {
      _result = Ok(initialValue);
    }
  }

  ///Wether or not the prop is valid to be displayed.
  bool get valid => _result != null && _result!.isOk;

  ///Wether or not the prop has an error
  bool get hasError => _result != null && _result!.isFailure;

  ///Force get the props value, will throw if [valid] is false
  T get require => _result!.require;

  ///Force get the props error, will throw if [hasError] is false
  Object get error => _result!.asFailure.error;

  ///Force get the stacktrace corresponding to [error], will throw if [hasError] is false.
  StackTrace? get stackTrace => _result!.asFailure.stackTrace;

  Result<T> get() {
    if (_result == null) {
      final st = StackTrace.current;

      return Failure(
        EarlyAccesError(
          'Attempted to acces prop before a result was retrieved ',
          st,
        ),
      );
    }

    return _result!;
  }

  ///Set the prop to [result]
  void set(Result<T> result) => _result = result;

  ///Set the prop to [Ok] of [value]
  void setOk(T value) => _result = Ok(value);

  ///Empty the prop
  void empty() => _result = null;

  @override
  int get hashCode => _result.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! Prop<T>) return false;
    return _result == other._result;
  }
}

final class EarlyAccesError implements Error {
  final String message;
  @override
  final StackTrace stackTrace;

  EarlyAccesError(this.message, this.stackTrace);

  @override
  String toString() =>
      'A Prop result was retrieved before it got instantiated.';
}
