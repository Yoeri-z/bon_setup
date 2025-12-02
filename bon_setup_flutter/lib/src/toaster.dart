import 'package:bon_setup_flutter/bon_setup_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType { succes, error, neutral }

extension ToastScopeContext on BuildContext {
  void showToast(String message, ToastType toastType) {
    final fToast = FToast();
    fToast.init(this);

    final toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: switch (toastType) {
          ToastType.succes => Colors.green,
          ToastType.error => colorScheme.error,
          ToastType.neutral => colorScheme.primary,
        },
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(switch (toastType) {
            ToastType.succes => Icons.check,
            ToastType.error => Icons.error,
            ToastType.neutral => Icons.info,
          }, color: colorScheme.onError),
          const SizedBox(width: 12.0),
          Text(message, style: TextStyle(color: colorScheme.onError)),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 2),
    );
  }
}
