import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension AppContext on BuildContext {
  ///The application colorscheme.
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  ///The application text theme.
  TextTheme get textTheme => Theme.of(this).textTheme;

  ///The applications primary color.
  Color get primaryColor => colorScheme.primary;

  ///The default title style.
  TextStyle? get title => textTheme.titleMedium;

  ///The default label style.
  TextStyle? get label => textTheme.labelMedium;

  ///The router that manages this context.
  GoRouter get router => GoRouter.of(this);

  ///The current page's route.
  Uri get route => router.state.uri;
}
