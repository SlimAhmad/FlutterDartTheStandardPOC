// Run with:  flutter test test/services/foundations/students/student_service_test.dart

import 'package:flutter_test/flutter_test.dart';

import 'student_service_test_base.dart';

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

    runRetrieveStudentByIdTests(base);

    runRetrieveAllStudentsTests(base);

    runRemoveStudentByIdTests(base);
  });
}
