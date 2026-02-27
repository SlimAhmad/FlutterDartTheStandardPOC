import 'i_logging_broker.dart';

class LoggingBroker implements ILoggingBroker {
  @override
  void logInformation(String message) => 
    print('[INFO] $message');

  @override
  void logWarning(String message) => 
    print('[WARN] $message');

  @override
  void logError(Exception exception, {String? message}) =>
      print('[ERROR] ${message ?? ''} $exception');

  @override
  void logCritical(Exception exception, {String? message}) =>
      print('[CRITICAL] ${message ?? ''} $exception');
}
