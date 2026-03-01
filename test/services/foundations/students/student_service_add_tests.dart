import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world/models/foundations/students/student.dart';
import 'package:mocktail/mocktail.dart';

import 'student_service_test_base.dart';

void runAddStudentTests(StudentServiceTestBase base) {
  group('addStudentAsync —', () {
    group('Add |', () {
      test(
        'GIVEN a valid student '
        'WHEN addStudentAsync is called '
        'THEN it should insert the student via the broker and return it',
        () async {
          // given
          final Student randomStudent = base.createRandomStudent();
          final Student inputStudent = randomStudent;
          final Student storageStudent = randomStudent;
          final Student expectedStudent = storageStudent;

          when(
            () => base.storageBrokerMock.insertStudentAsync(inputStudent),
          ).thenAnswer((_) async => storageStudent);

          // when
          final Student actualStudent = await base.studentService
              .addStudentAsync(inputStudent);

          // then
          expect(actualStudent, equals(expectedStudent));

          verify(
            () => base.storageBrokerMock.insertStudentAsync(inputStudent),
          ).called(1);

          verifyNoMoreInteractions(base.storageBrokerMock);
          verifyNoMoreInteractions(base.loggingBrokerMock);
        },
      );
    });
  });
}
