part of 'student_service.dart';

extension StudentServiceExceptions on StudentService {
  
  Future<T> tryCatch<T>(Future<T> Function() function) async {
    try {
      return await function();
    } on StudentValidationException {
      rethrow;
    } on StudentDependencyValidationException {
      rethrow;
    } on LockedUserStudentException catch (e) {
      throw StudentDependencyValidationException(
        message: 'Student dependency validation error occurred, please try again.',
        innerException: e,
      );
    } on FailedStudentRequestException catch (e) {
      loggingBroker.logError(e.innerException, message: e.message);
      throw StudentDependencyException(
        message: 'Student dependency error occurred, contact support.',
        innerException: e,
      );
    } on FailedStudentConfigurationException catch (e) {
      loggingBroker.logCritical(e.innerException, message: e.message);
      throw StudentDependencyException(
        message: 'Student dependency error occurred, contact support.',
        innerException: e,
      );
    } on Exception catch (e) {
      final failedDependency = FailedStudentDependencyException(
        innerException: e,
      );
      loggingBroker.logError(e, message: e.toString());
      throw StudentDependencyException(
        message: 'Student dependency error occurred, contact support.',
        innerException: failedDependency,
      );
    }
  }

  Future<T> tryCatchService<T>(Future<T> Function() function) async {
    try {
      return await function();
    } on StudentValidationException {
      rethrow;
    } on StudentDependencyValidationException {
      rethrow;
    } on StudentDependencyException {
      rethrow;
    } on Exception catch (e) {
      final failedService = FailedStudentServiceException(
        innerException: e,
      );
      loggingBroker.logCritical(e, message: 'Unexpected service failure.');
      throw StudentServiceException(
        message: 'Student service error occurred, contact support.',
        innerException: failedService,
      );
    }
  }
}
