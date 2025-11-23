abstract class AppLogger {
  const AppLogger();

  void debug(dynamic message, [DateTime? time, Object? error, StackTrace? stackTrace]);
  void error(dynamic message, [DateTime? time, Object? error, StackTrace? stackTrace]);
  void warning(dynamic message, [DateTime? time, Object? error, StackTrace? stackTrace ]);
  void info(dynamic message, [DateTime? time, Object? error, StackTrace? stackTrace]);
  void append(dynamic message);
  void closeAppend();
}
