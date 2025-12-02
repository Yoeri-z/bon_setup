A collection of utilities is use in my projects.

# Contents

This package contains the following:

- All the contents of the bon_setup package (dependency injection, logging utilities, functional result pattern)
- The `Provider`, widget from `provider` and a custom `NotifierProvider` widget built with `provider`.
- The entirety of `go_router`.
- A `Prop` class to wrap values that are to be displayed on ui.
- A `Guard` and `MultiGuard` widget to guard against invalid `Prop`s being displayed.
- A `GuardedProvider` which is a `ChangeNotifierProvider` and `MultiGuard` in one widget.
- A few useful `BuildContext` extensions.
- An implementation of toast notifications using `fluttertoast`.
- A toast mixin to allow notifiers to easily display toasts for all notifiers provided by `NotifierProvider`.
