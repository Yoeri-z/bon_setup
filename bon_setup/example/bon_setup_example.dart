import 'dart:math';

import 'package:bon_setup/bon_setup.dart';

Result<int> unsafeTask(Random random) {
  final num = random.nextInt(100);

  if (num < 50) {
    return Ok(num);
  } else {
    return Failure("Number was too high", StackTrace.current);
  }
}

void main() {
  final random = Random();

  var result = unsafeTask(random);

  print(result.isOk);
  print(result.isFailure);

  result.fold(
    onOk: (value) => print("Result of task was $value"),
    onFailure: (error, st) => print("Task failed"),
  );

  result = result.map((val) => val * 2);

  final count = result.fold(
    onOk: (value) => value,
    onFailure: (error, st) => 0,
  );

  print("Resolved count $count");
}
