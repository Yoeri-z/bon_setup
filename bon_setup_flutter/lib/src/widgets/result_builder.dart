import 'package:bon_setup/bon_setup.dart';
import 'package:bon_setup_flutter/src/widgets/loading_widget.dart';
import 'package:flutter/widgets.dart';

///A result builder, similar to FutureBuilder, but for functions that already handle errors themselves,
///and return a [Result].
class ResultBuilder<T> extends StatefulWidget {
  const ResultBuilder({
    super.key,
    this.initialData,
    required this.future,
    required this.builder,
  });

  final Future<Result<T>>? future;
  final T? initialData;
  final Widget Function(BuildContext context, T value) builder;

  @override
  State<ResultBuilder<T>> createState() => _ResultBuilderState<T>();
}

class _ResultBuilderState<T> extends State<ResultBuilder<T>> {
  /// An object that identifies the currently active callbacks. Used to avoid
  /// calling setState from stale callbacks, e.g. after disposal of this state,
  /// or after widget reconfiguration to a new Future.
  Object? _activeCallbackIdentity;
  late Result<T>? _result;

  @override
  void initState() {
    super.initState();
    _result = widget.initialData == null ? null : Ok(widget.initialData as T);
    _subscribe();
  }

  @override
  void didUpdateWidget(ResultBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.future == widget.future) {
      return;
    }
    if (_activeCallbackIdentity != null) {
      _unsubscribe();
      _result = null;
    }
    _subscribe();
  }

  @override
  Widget build(BuildContext context) => switch (_result) {
    null => const LoadingWidget(),
    Failure _ => const Text('An unexpected error occured'),
    Ok<T> ok => widget.builder(context, ok.value),
  };

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() {
    if (widget.future == null) {
      // There is no future to subscribe to, do nothing.
      return;
    }
    final Object callbackIdentity = Object();
    _activeCallbackIdentity = callbackIdentity;
    widget.future!.then<void>((Result<T> data) {
      if (_activeCallbackIdentity == callbackIdentity) {
        setState(() {
          _result = data;
        });
      }
    });
  }

  void _unsubscribe() {
    _activeCallbackIdentity = null;
  }
}
