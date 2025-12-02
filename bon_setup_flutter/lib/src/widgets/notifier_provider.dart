import 'package:bon_setup_flutter/src/mixins/toast_mixin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotifierProvider<T extends ChangeNotifier> extends ListenableProvider<T> {
  /// Creates a [ValueNotifier] or [ChangeNotifier] using `create` and automatically
  /// disposes it when [NotifierProvider] is removed from the widget tree.
  NotifierProvider({
    super.key,
    required Create<T> create,
    super.lazy,
    super.builder,
    super.child,
  }) : super(
         create: (context) {
           final notif = create(context);
           _registerToast(context, notif);
           return notif;
         },
         dispose: _dispose,
       );

  /// Provides an existing [ValueNotifier] or [ChangeNotifier].
  NotifierProvider.value({
    super.key,
    required T value,
    super.builder,
    super.child,
  }) //instead of using [super.value] we register and deregister toast to the nearest context using create and dispose.
  : super(
         create: (context) {
           _deregisterToast(value);
           _registerToast(context, value);
           return value;
         },
         dispose: (_, value) => _deregisterToast(value),
       );

  static void _registerToast(BuildContext context, ChangeNotifier notifier) {
    if (notifier is ToastNotifier) {
      (notifier as ToastNotifier).registerContext(context);
    }
  }

  static void _deregisterToast(ChangeNotifier notifier) {
    if (notifier is ToastNotifier) {
      (notifier as ToastNotifier).deregisterContext();
    }
  }

  static void _dispose(BuildContext context, ChangeNotifier notifier) {
    _deregisterToast(notifier);
    notifier.dispose();
  }
}
