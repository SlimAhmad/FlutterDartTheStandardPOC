// student_service_test.dart
//
// This is the single entry point for ALL StudentService tests.
// It follows Hassan Habib's Standard: each operation has its own partial file
// covering happy path, validation exceptions, and dependency exceptions.
//
// Run with:  flutter test test/services/foundations/students/student_service_test.dart

import 'package:flutter_test/flutter_test.dart';

import 'student_service_test_base.dart';

// Partial test suites (one file per operation)
import 'student_service_add_tests.dart';
import 'student_service_add_validation_tests.dart';
import 'student_service_add_dependency_tests.dart';
import 'student_service_retrieve_by_id_tests.dart';
import 'student_service_retrieve_all_tests.dart';
import 'student_service_modify_tests.dart';
import 'student_service_remove_tests.dart';

void main() {
  final base = StudentServiceTestBase();

  setUp(() => base.setUpStudentServiceTests());

  group('StudentService |', () {

    runAddStudentTests(base);
    runAddStudentValidationTests(base);
    runAddStudentDependencyTests(base);

    runRetrieveStudentByIdTests(base);

    runRetrieveAllStudentsTests(base);

    runModifyStudentTests(base);

    runRemoveStudentByIdTests(base);
  });
}
