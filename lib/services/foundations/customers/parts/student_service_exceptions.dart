part of '../student_service.dart';

extension StudentServiceExceptions on StudentService {
  
    Future<Student> tryCatch(Future<Student> Function() function) async {
    try {

      return await function();

    } on NullStudentException catch (nullStudentException) {

      throw await _createAndLogValidationExceptionAsync(nullStudentException);

    } on InvalidStudentException catch (invalidStudentException) {

      throw await _createAndLogValidationExceptionAsync(invalidStudentException);

    } on StudentValidationException catch (studentValidationException) {

      throw await _createAndLogValidationExceptionAsync(
        studentValidationException.innerException);

    }on FailedDependencyHttpException catch (failedDependencyHttpException) {

      final failedStudentDependencyException =
          FailedStudentDependencyException(
            message: "Failed student dependency error occurred, contact support.",
            innerException: failedDependencyHttpException);

      throw await _createAndLogCriticalDependencyExceptionAsync(failedStudentDependencyException);

    } on NotFoundHttpException catch (notFoundHttpException) {

      final notFoundStudentException = NotFoundStudentException(
        message: "Failed Student configuration error occurred, contact support.",
        innerException: notFoundHttpException,
      );

      throw await _createAndLogCriticalDependencyExceptionAsync(notFoundStudentException);

    } on UnauthorizedHttpException catch (unauthorizedHttpException) {

      final unauthorizedStudentException = FailedStudentDependencyException(
        message: "Failed Student dependency error occurred, contact support.",
        innerException: unauthorizedHttpException,
      );
      
      throw await _createAndLogCriticalDependencyExceptionAsync(unauthorizedStudentException);

    } on LockedHttpException catch (lockedHttpException) {

        final lockedStudentException =
          LockedUserStudentException(
            message: "Locked Student error occurred, please try again later.",
            innerException: lockedHttpException);

        throw await _createAndLogDependencyValidationExceptionAsync(lockedStudentException);

    } on BadRequestHttpException catch (badRequestHttpException) {

       final invalidStudentException =
          InvalidStudentException(
            message: "Invalid Student error occurred. please correct the errors and try again.",
            innerException: badRequestHttpException,
            data: badRequestHttpException.data ?? {});

        throw await _createAndLogDependencyValidationExceptionAsync(invalidStudentException);

    } on ConflictHttpException catch (conflictHttpException) {

        final invalidStudentException =
            InvalidStudentException(
              message: "Invalid Student error occurred. please correct the errors and try again.",
              innerException: conflictHttpException,
              data: conflictHttpException.data ?? {});

        throw await _createAndLogDependencyValidationExceptionAsync(invalidStudentException);

     }on Exception catch(exception) {

      final failedStudentServiceException =
          FailedStudentServiceException(
             message: "Failed Student service error occurred, contact support.",
             innerException: exception);

      throw await _createAndLogServiceExceptionAsync(failedStudentServiceException);
    }
   }

   Future<List<Student>> tryCatchList(Future<List<Student>> Function() function) async {
    try {
      return await function();
    } on FailedDependencyHttpException catch (failedDependencyHttpException) {

      final failedStudentDependencyException =
          FailedStudentDependencyException(
            message: "Failed student dependency error occurred, contact support.",
            innerException: failedDependencyHttpException);

      throw await _createAndLogCriticalDependencyExceptionAsync(failedStudentDependencyException);

    } on NotFoundHttpException catch (notFoundHttpException) {

      final notFoundStudentException = NotFoundStudentException(
        message: "Failed Student configuration error occurred, contact support.",
        innerException: notFoundHttpException,
      );

      throw await _createAndLogCriticalDependencyExceptionAsync(notFoundStudentException);

    }on Exception catch(exception) {

      final failedStudentServiceException =
          FailedStudentServiceException(
             message: "Failed Student service error occurred, contact support.",
             innerException: exception);

      throw await _createAndLogServiceExceptionAsync(failedStudentServiceException);
    }
   }

  Future<StudentValidationException> _createAndLogValidationExceptionAsync(
    Exception exception,
  ) async {
    final studentValidationException = StudentValidationException(
      message: 'Student validation error occurred, fix the errors and try again.',
      innerException: exception,
    );
    loggingBroker.logError(studentValidationException);
    return studentValidationException;
  }

  Future<StudentDependencyValidationException>
      _createAndLogDependencyValidationExceptionAsync(
    Exception exception,
  ) async {
    final studentDependencyValidationException = StudentDependencyValidationException(
      message: 'Student validation error occurred, fix the errors and try again.',
      innerException: exception,
    );
    loggingBroker.logError(studentDependencyValidationException);
    return studentDependencyValidationException;
  }

  Future<StudentDependencyException> _createAndLogCriticalDependencyExceptionAsync(
    Exception exception,
  ) async {
    final studentDependencyException = StudentDependencyException(
      message: 'Student dependency error occurred, contact support.',
      innerException: exception,
    );
    loggingBroker.logCritical(studentDependencyException);
    return studentDependencyException;
  }

  Future<StudentDependencyException> _createAndLogDependencyExceptionAsync(
    Exception exception
  ) async {
    final studentDependencyException = StudentDependencyException(
      message: 'Student dependency error occurred, contact support.',
      innerException: exception,
    );
    loggingBroker.logError(studentDependencyException);
    return studentDependencyException;
  }

  Future<StudentServiceException> _createAndLogServiceExceptionAsync(
    Exception exception
  ) async {
    final studentServiceException = StudentServiceException(
      message: 'Student service error occurred, contact support.',
      innerException: exception,
    );
    loggingBroker.logError(studentServiceException);
    return studentServiceException;
  }
}
