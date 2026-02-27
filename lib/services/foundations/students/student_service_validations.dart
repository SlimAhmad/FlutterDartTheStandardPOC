part of 'student_service.dart';

extension StudentServiceValidations on StudentService {
  
  void validateStudentOnAdd(Student? student) {
    _validateStudentNotNull(student);

    final Map<String, List<String>> errors = {};

    _isInvalid(errors, 'Id', student!.id.isEmpty, 'Id is required.');
    _isInvalid(errors, 'Name', student.name.trim().isEmpty, 'Name is required.');
    _isInvalid(errors, 'Email', student.email.trim().isEmpty, 'Email is required.');
    _isInvalid(
      errors,
      'Email',
      !_isValidEmail(student.email),
      'Email is not a valid address.',
    );
    _isInvalid(
      errors,
      'CreatedDate',
      student.createdDate == DateTime(0),
      'CreatedDate is required.',
    );
    _isInvalid(
      errors,
      'UpdatedDate',
      student.updatedDate == DateTime(0),
      'UpdatedDate is required.',
    );
    _isInvalid(
      errors,
      'UpdatedDate',
      student.updatedDate != student.createdDate,
      'UpdatedDate must match CreatedDate on add.',
    );

    if (errors.isNotEmpty) {
      throw StudentValidationException(
        innerException: InvalidStudentException(data: errors),
      );
    }
  }

  void validateStudentOnModify(Student? student) {
    _validateStudentNotNull(student);

    final Map<String, List<String>> errors = {};

    _isInvalid(errors, 'Id', student!.id.isEmpty, 'Id is required.');
    _isInvalid(errors, 'Name', student.name.trim().isEmpty, 'Name is required.');
    _isInvalid(errors, 'Email', student.email.trim().isEmpty, 'Email is required.');
    _isInvalid(
      errors,
      'Email',
      !_isValidEmail(student.email),
      'Email is not a valid address.',
    );
    _isInvalid(
      errors,
      'UpdatedDate',
      !student.updatedDate.isAfter(student.createdDate),
      'UpdatedDate must be after CreatedDate on modify.',
    );

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
          data: {'Id': ['Id is required.']},
        ),
      );
    }
  }

  void validateStorageStudent(Student? storageStudent, String studentId) {
    if (storageStudent == null) {
      throw StudentValidationException(
        innerException: NotFoundStudentException(
          message: 'Could not find student with id: $studentId',
        ),
      );
    }
  }

  void _validateStudentNotNull(Student? student) {
    if (student == null) {
      throw StudentValidationException(
        innerException: NullStudentException(
          message: 'Student is null.'
        ),
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

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }
}
