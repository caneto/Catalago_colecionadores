import 'package:logger/logger.dart';

import 'app_logger.dart';

class AppLoggerImpl implements AppLogger {
  final _logger = Logger(
    filter: ProductionFilter(),
    printer: PrettyPrinter(dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart, lineLength: 74, methodCount: 0),
  );
  var _messages = <String>[];

  @override
  void debug(dynamic message, [time, error, StackTrace? stackTrace]) =>
      _logger.d(message, error: error, stackTrace: stackTrace);

  @override
  void error(message, [time, error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);

  @override
  void info(message, [time, error, StackTrace? stackTrace]) =>
      _logger.i(message, error: error, stackTrace: stackTrace);

  @override
  void warning(message, [time, error, StackTrace? stackTrace]) =>
      _logger.w(message, error: error, stackTrace: stackTrace);

  @override
  void append(message) => _messages.add(message);

  @override
  void closeAppend() {
    info(_messages.join('\n'));
    _messages = const <String>[];
  }
}
