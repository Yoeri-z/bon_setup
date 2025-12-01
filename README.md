This is a personal collection of flutter utilities that i like to use or built myself.

# Contents of the packages

**bon_setup (dart & flutter):**
 - dependency injection with `get_it` in the `Services` class.
 - logging with `logger` in the `Services` class
 - `Result`, `Ok`, and `Failure` classes to do error handling the "functional" way.
 - method to log unsafe calls and also convert them to `Results`

**bon_setup_flutter (flutter only):**
  - `Provider`, `ChangeNotifier`, and `ProxyProvider` from `provider`.
  - `Prop` class to wrap properties inside `ChangeNotifier`s that are intended to be displayed in the UI.
  - `Guard` and `MultiGuard` widget to prevent invalid `Prop`s to be displayed on the ui.
  - `GuardedProvider`, which is a combination of `ChangeNotifierProvider` and `MultiGuard`.
  - useful `BuildContext` extensions to reduce boilerplate.
