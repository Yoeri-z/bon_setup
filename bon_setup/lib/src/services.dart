import 'dart:io';

import 'package:bon_setup/bon_setup.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/web.dart';

final _printer = PrettyPrinter(
  dateTimeFormat: DateTimeFormat.dateAndTime,
  methodCount: 0,
  errorMethodCount: 25,
);

class Services {
  ///Global Dependency Injection (DI) service.
  static final GetIt di = GetIt.instance;

  static final _fileOutput = LogFileOutput();

  ///The globally available logger
  static final Logger logger = Logger(
    printer: _printer,
    output: MultiOutput([ConsoleOutput(), LogFileOutput()]), // default
  );

  ///Set the logs output file to a new file
  static Future<void> setLoggerOutputFile(File newFile) async {
    await _fileOutput.setFile(newFile);
  }
}

class LogFileOutput extends LogOutput {
  IOSink? sink;
  File? _file;

  LogFileOutput({File? initialFile}) : _file = initialFile;

  bool get isWindows => Platform.isWindows;

  @override
  Future<void> init() async {
    sink = _file?.openWrite();
  }

  @override
  void output(OutputEvent event) {
    sink?.writeln('${event.level.name} at ${event.origin.time}');
    sink?.writeln('Message: ${event.origin.message}');
    sink?.writeln('Error: ${event.origin.error}');
    sink?.writeln('Stacktrace:');
    sink?.write(event.origin.stackTrace);
    sink?.writeln();
  }

  @override
  Future<void> destroy() async {
    await sink?.close();
  }

  Future<void> setFile(File file) async {
    _file = file;
    await sink?.close();
    sink = file.openWrite();
  }
}

extension GuardExtension<T extends Object?> on Future<T> {
  ///Wrap this future to return a type of [Result]
  Future<Result<T>> guard(String message) async {
    try {
      return Ok(await this);
    } catch (e, st) {
      Services.logger.log(Level.error, message, error: e, stackTrace: st);

      return Failure(e, stackTrace: st);
    }
  }
}
