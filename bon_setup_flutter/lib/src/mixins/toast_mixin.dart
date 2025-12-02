import 'dart:collection';

import 'package:bon_setup_flutter/bon_setup_flutter.dart';
import 'package:flutter/material.dart';

abstract interface class ToastNotifier {
  void registerContext(BuildContext context);

  void deregisterContext();

  void showToast(String message, ToastType toastType);
}

///Adds ability for notifiers to show toasts without caring too much about [BuildContext].
///If [NotifierProvider] or [NotifierProvider.value] were used to provide the notifier this should never happen.
///
///Otherwise you should provide valid context using [registerContext] and [deregisterContext]
mixin Toaster on ChangeNotifier {
  BuildContext? _context;

  ///The toast message queue built up by this notifier.
  ///
  ///Usefull to test the notifiers toasting capabilities without inflating a widget tree.
  @visibleForTesting
  final messageQueue = Queue<(String, ToastType)>();

  @visibleForTesting
  bool isTesting = false;

  ///Register a context to be used for showing toasts
  void registerContext(BuildContext context) {
    _context = context;
  }

  ///Deregister the context this notifier has
  void deregisterContext() {
    _context = null;
  }

  ///Mark this notifier to let it know its in a testing environment.
  @visibleForTesting
  void markIsTesting();

  void showToast(String message, ToastType toastType) {
    if (!isTesting && (_context == null || !_context!.mounted)) {
      Service.logger.w(
        "Tried to show toast in $runtimeType without a valid context",
      );
    }
    _context?.showToast(message, toastType);

    if (isTesting) {
      messageQueue.add((message, toastType));
    }
  }

  @override
  void dispose() {
    deregisterContext();
    super.dispose();
  }
}
