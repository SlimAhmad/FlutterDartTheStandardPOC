class NullStudentViewException implements Exception {
  final String message;

  const NullStudentViewException({this.message = 'Student is null.'});

  @override
  String toString() => 'NullStudentViewException: $message';
}

class InvalidStudentViewException implements Exception {
  final String message;

  const InvalidStudentViewException({
    this.message =
        'Invalid student view. Please correct the errors and try again.',
  });

  @override
  String toString() => 'InvalidStudentViewException: $message';
}

class FailedStudentViewServiceException implements Exception {
  final String message;
  final Exception innerException;

  const FailedStudentViewServiceException({
    this.message =
        'Failed student view service error occurred, contact support.',
    required this.innerException,
  });

  @override
  String toString() =>
      'FailedStudentViewServiceException: $message'
      '\n  InnerException: $innerException';
}

//Categorical exceptions:

class StudentViewValidationException implements Exception {
  final String message;
  final Exception innerException;

  const StudentViewValidationException({
    this.message = 'Student validation error occurred, please try again.',
    required this.innerException,
  });

  @override
  String toString() =>
      'StudentViewValidationException: $message'
      '\n  InnerException: $innerException';
}

class StudentViewServiceException implements Exception {
  final String message;
  final Exception innerException;

  const StudentViewServiceException({
    this.message = 'Student service error occurred, contact support.',
    required this.innerException,
  });

  @override
  String toString() =>
      'StudentViewServiceException: $message'
      '\n  InnerException: $innerException';
}

class StudentViewDependencyValidationException implements Exception {
  final String message;
  final Exception innerException;

  const StudentViewDependencyValidationException({
    this.message =
        'Student dependency validation error occurred, please try again.',
    required this.innerException,
  });

  @override
  String toString() =>
      'StudentViewDependencyValidationException: $message'
      '\n  InnerException: $innerException';
}

class StudentViewDependencyException implements Exception {
  final String message;
  final Exception innerException;

  const StudentViewDependencyException({
    this.message = 'Student dependency error occurred, contact support.',
    required this.innerException,
  });

  @override
  String toString() =>
      'StudentViewDependencyException: $message'
      '\n  InnerException: $innerException';
}
