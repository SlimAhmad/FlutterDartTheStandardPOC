part of '../student_view_service.dart';

extension StudentViewServiceExceptions on StudentViewService {
  Future<StudentView> tryCatch(
    Future<StudentView> Function() returningStudentViewFunction,
  ) async {
    try {
      return await returningStudentViewFunction();
    } on NullStudentViewException catch (nullStudentViewException) {
      throw await _createAndLogValidationExceptionAsync(
        nullStudentViewException,
      );
    } on InvalidStudentViewException catch (invalidStudentViewException) {
      throw await _createAndLogValidationExceptionAsync(
        invalidStudentViewException,
      );
    } on StudentValidationException catch (studentValidationException) {
      throw await _createAndLogDependencyValidationExceptionAsync(
        studentValidationException,
      );
    } on StudentDependencyValidationException catch (
      studentDependencyValidationException
    ) {
      throw await _createAndLogDependencyValidationExceptionAsync(
        studentDependencyValidationException,
      );
    } on StudentDependencyException catch (studentDependencyException) {
      throw await _createAndLogDependencyExceptionAsync(
        studentDependencyException,
      );
    } on StudentServiceException catch (studentServiceException) {
      throw await _createAndLogDependencyExceptionAsync(
        studentServiceException,
      );
    } on Exception catch (exception) {
      var failedStudentViewServiceException = FailedStudentViewServiceException(
        message: "Failed Student service error occurred, contact support.",
        innerException: exception,
      );

      throw await _createAndLogServiceExceptionAsync(
        failedStudentViewServiceException,
      );
    }
  }

  Future<List<StudentView>> tryCatchList(
    Future<List<StudentView>> Function() returningStudentViewsFunction,
  ) async {
    try {
      return await returningStudentViewsFunction();
    } on StudentDependencyException catch (studentDependencyException) {
      throw await _createAndLogDependencyExceptionAsync(
        studentDependencyException,
      );
    } on StudentServiceException catch (studentServiceException) {
      throw await _createAndLogDependencyExceptionAsync(
        studentServiceException,
      );
    } on Exception catch (exception) {
      var failedStudentViewServiceException = FailedStudentViewServiceException(
        message: "Failed Student service error occurred, contact support.",
        innerException: exception,
      );

      throw await _createAndLogServiceExceptionAsync(
        failedStudentViewServiceException,
      );
    }
  }

  Future<StudentViewValidationException> _createAndLogValidationExceptionAsync(
    Exception exception,
  ) async {
    var studentViewValidationException = StudentViewValidationException(
      message:
          "Student validation error occurred, fix the errors and try again.",
      innerException: exception,
    );

    loggingBroker.logError(studentViewValidationException);

    return studentViewValidationException;
  }

  Future<StudentViewDependencyValidationException>
  _createAndLogDependencyValidationExceptionAsync(Exception exception) async {
    var studentViewDependencyValidationException =
        StudentViewDependencyValidationException(
          message:
              "Student validation error occurred, fix errors and try again.",
          innerException: exception,
        );

    loggingBroker.logError(studentViewDependencyValidationException);

    return studentViewDependencyValidationException;
  }

  Future<StudentViewDependencyException> _createAndLogDependencyExceptionAsync(
    Exception exception,
  ) async {
    var studentViewDependencyException = StudentViewDependencyException(
      message: "Student dependency error occurred, contact support.",
      innerException: exception,
    );

    loggingBroker.logError(studentViewDependencyException);

    return studentViewDependencyException;
  }

  Future<StudentViewServiceException> _createAndLogServiceExceptionAsync(
    Exception exception,
  ) async {
    var studentViewServiceException = StudentViewServiceException(
      message: "Student service error occurred, contact support.",
      innerException: exception,
    );

    loggingBroker.logError(studentViewServiceException);

    return studentViewServiceException;
  }
}
