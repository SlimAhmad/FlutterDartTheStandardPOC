abstract class ILoggingBroker {
  void logInformation(String message);
  void logWarning(String message);
  void logError(Exception exception, {String? message});
  void logCritical(Exception exception, {String? message});
}
