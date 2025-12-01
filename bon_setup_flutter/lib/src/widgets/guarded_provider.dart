import 'package:bon_setup_flutter/src/prop.dart';
import 'package:bon_setup_flutter/src/widgets/guard_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

///A special [ChangeNotifierProvider] that also listens to it and guards the props returned by [props]
class GuardedProvider<T extends ChangeNotifier> extends StatelessWidget {
  const GuardedProvider({
    super.key,
    required this.create,
    required this.props,
    required this.builder,
  });

  final T Function(BuildContext context) create;

  ///The props of the notifier to be guarded
  final List<Prop> Function(T notifier) props;
  final Widget Function(BuildContext context, T notifier) builder;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: create,
      builder: (context, child) {
        final notif = context.watch<T>();
        return MultiGuard(
          props: props(notif),
          builder: (context) => builder(context, notif),
        );
      },
    );
  }
}
