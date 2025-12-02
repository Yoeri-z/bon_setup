import 'package:bon_setup_flutter/bon_setup_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class CounterNotifier extends ChangeNotifier with Toaster {
  final count = Prop(0);

  void increment() {
    if (!count.valid) return;

    if (count.require > 10) {
      count.set(
        Failure("Count is greater than 10", stackTrace: StackTrace.current),
      );

      notifyListeners();
      return;
    }

    count.setOk(count.require + 1);

    showToast('Count incremented', ToastType.succes);
    Services.logger.i("Incremented count");

    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: GuardedProvider(
        create: (context) => CounterNotifier(),
        props: (notifier) => [notifier.count],
        builder: (context, notif) =>
            const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final notif = context.watch<CounterNotifier>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              notif.count.require.toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: notif.increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
