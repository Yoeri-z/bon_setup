import 'package:bon_setup_flutter/src/prop.dart';
import 'package:bon_setup_flutter/src/widgets/loading_widget.dart';
import 'package:flutter/widgets.dart';

class Guard<T> extends StatelessWidget {
  const Guard({super.key, required this.property, required this.builder});

  final Prop<T> property;
  final Widget Function(BuildContext context, T property) builder;

  @override
  Widget build(BuildContext context) {
    if (property.valid) {
      return builder(context, property.require);
    }
    if (property.hasError) {
      return Center(child: Text('An unexpected error occured'));
    }
    return LoadingWidget();
  }
}

class MultiGuard extends StatelessWidget {
  const MultiGuard({super.key, required this.props, required this.builder});

  final List<Prop> props;
  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    if (props.every((prop) => prop.valid)) return builder(context);
    if (props.any((prop) => prop.hasError)) {
      return Center(child: const Text('An unexpected error occured'));
    }

    return LoadingWidget();
  }
}
