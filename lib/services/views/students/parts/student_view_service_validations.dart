part of '../student_view_service.dart';

extension StudentViewServiceValidations on StudentViewService {
  void validateStudentView(StudentView? student) {
    _validateStudentNotNull(student);

    final Map<String, List<String>> errors = {};

    _isInvalid(errors, 'Id', student!.id.isEmpty, 'Id is required.');

    if (errors.isNotEmpty) {
      throw StudentValidationException(
        innerException: InvalidStudentException(data: errors),
      );
    }
  }

  void validateStudentId(String studentId) {
    if (studentId.isEmpty) {
      throw StudentValidationException(
        innerException: InvalidStudentException(
          data: {
            'Id': ['Id is required.'],
          },
        ),
      );
    }
  }

  void _validateStudentNotNull(StudentView? student) {
    if (student == null) {
      throw StudentValidationException(
        innerException: NullStudentException(message: 'Student is null.'),
      );
    }
  }

  void _isInvalid(
    Map<String, List<String>> errors,
    String field,
    bool condition,
    String errorMessage,
  ) {
    if (condition) {
      errors.putIfAbsent(field, () => []).add(errorMessage);
    }
  }
}
