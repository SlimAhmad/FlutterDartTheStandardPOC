
class NullStudentException implements Exception {
  final String message;

  const NullStudentException({
    this.message = 'Student is null.',
  });

  @override
  String toString() =>
      'NotFoundStudentException: $message';
}

class NotFoundStudentException implements Exception {
  final String message;
  final Exception? innerException;
  final Map<String, dynamic>? data;

  const NotFoundStudentException({
    this.message = 'Student not found.',
    this.innerException,
    this.data,
  });

  @override
  String toString() =>
      'NotFoundStudentException: $message'
      '${innerException != null ? '\n  InnerException: $innerException' : ''}'
      '${data != null ? '\n  Data: $data' : ''}';
}

class LockedUserStudentException implements Exception {
  final String message;
  final Exception innerException;

  const LockedUserStudentException({
    this.message = 'Student record is locked.',
    required this.innerException,
  });

  @override
  String toString() =>
      'LockedUserStudentException: $message'
      '\n  InnerException: $innerException';
}

class InvalidStudentException implements Exception {
  final String message;
  final Exception? innerException;
  final Map<String, dynamic> data; 

  const InvalidStudentException({
    this.message = 'Invalid student. Please correct the errors and try again.',
    this.innerException,
    this.data = const {},
  });

  @override
  String toString() =>
      'InvalidStudentException: $message'
      '${innerException != null ? '\n  InnerException: $innerException' : ''}'
      '\n  Data: $data';
}

class FailedStudentServiceException implements Exception {
  final String message;
  final Exception innerException;

  const FailedStudentServiceException({
    this.message = 'Failed student service error occurred, contact support.',
    required this.innerException,
  });

  @override
  String toString() =>
      'FailedStudentServiceException: $message'
      '\n  InnerException: $innerException';
}

class FailedStudentRequestException implements Exception {
  final String message;
  final Exception innerException;

  const FailedStudentRequestException({
    this.message = 'Failed student request error occurred, please try again.',
    required this.innerException,
  });

  @override
  String toString() =>
      'FailedStudentRequestException: $message'
      '\n  InnerException: $innerException';
}

class FailedStudentDependencyException implements Exception {
  final String message;
  final Exception innerException;

  const FailedStudentDependencyException({
    this.message = 'Failed student dependency error occurred, contact support.',
    required this.innerException,
  });

  @override
  String toString() =>
      'FailedStudentDependencyException: $message'
      '\n  InnerException: $innerException';
}

class FailedStudentConfigurationException implements Exception {
  final String message;
  final Exception innerException;

  const FailedStudentConfigurationException({
    this.message = 'Failed student configuration error occurred, contact support.',
    required this.innerException,
  });

  @override
  String toString() =>
      'FailedStudentConfigurationException: $message'
      '\n  InnerException: $innerException';
}

//Categorical exceptions:

class StudentValidationException implements Exception {
  final String message;
  final Exception innerException;

  const StudentValidationException({
    this.message = 'Student validation error occurred, please try again.',
    required this.innerException,
  });

  @override
  String toString() =>
      'StudentValidationException: $message'
      '\n  InnerException: $innerException';
}

class StudentServiceException implements Exception {
  final String message;
  final Exception innerException;

  const StudentServiceException({
    this.message = 'Student service error occurred, contact support.',
    required this.innerException,
  });

  @override
  String toString() =>
      'StudentServiceException: $message'
      '\n  InnerException: $innerException';
}

class StudentDependencyValidationException implements Exception {
  final String message;
  final Exception innerException;

  const StudentDependencyValidationException({
    this.message = 'Student dependency validation error occurred, please try again.',
    required this.innerException,
  });

  @override
  String toString() =>
      'StudentDependencyValidationException: $message'
      '\n  InnerException: $innerException';
}

class StudentDependencyException implements Exception {
  final String message;
  final Exception innerException;

  const StudentDependencyException({
    this.message = 'Student dependency error occurred, contact support.',
    required this.innerException,
  });

  @override
  String toString() =>
      'StudentDependencyException: $message'
      '\n  InnerException: $innerException';
}
