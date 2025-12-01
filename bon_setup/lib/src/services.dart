import 'package:bon_setup/bon_setup.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/web.dart';

abstract class Service {
  static final GetIt di = GetIt.instance;
  static Logger logger = Logger();
}

extension GuardExtension<T extends Object?> on Future<T> {
  ///Wrap this future to return a type of [Result]
  Future<Result<T>> guard(String message) async {
    try {
      return Ok(await this);
    } catch (e, st) {
      Service.logger.log(Level.error, message, error: e, stackTrace: st);

      return Failure(e, stackTrace: st);
    }
  }
}
