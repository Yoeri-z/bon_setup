This is a personal collection of flutter utilities that i like to use or built myself.

# Contents of the packages

**bon_setup (dart & flutter):**

- dependency injection with `get_it` in the `Services` class.
- logging with `logger` in the `Services` class
- `Result`, `Ok`, and `Failure` classes to do error handling the "functional" way.
- method to log unsafe calls and also convert them to `Results`

**bon_setup_flutter (flutter only):**

- All the contents of the bon_setup package (dependency injection, logging utilities, functional result pattern)
- The `Provider`, widget from `provider` and a custom `NotifierProvider` widget built with `provider`.
- The entirety of `go_router`.
- A `Prop` class to wrap values that are to be displayed on ui.
- A `Guard` and `MultiGuard` widget to guard against invalid `Prop`s being displayed.
- A `GuardedProvider` which is a `ChangeNotifierProvider` and `MultiGuard` in one widget.
- A few useful `BuildContext` extensions.
- An implementation of toast notifications using `fluttertoast`.
- A toast mixin to allow notifiers to easily display toasts for all notifiers provided by `NotifierProvider`.
