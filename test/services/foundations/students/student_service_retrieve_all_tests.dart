import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world/models/foundations/students/student.dart';
import 'package:hello_world/models/foundations/students/student_exceptions.dart';
import 'package:mocktail/mocktail.dart';

import 'student_service_test_base.dart';

void runRetrieveAllStudentsTests(StudentServiceTestBase base) {
  group('retrieveAllStudentsAsync —', () {
    group('retrieveAll |', () {
      test('GIVEN students exist in storage '
          'WHEN retrieveAllStudentsAsync is called '
          'THEN it should return all students from storage', () async {
        // Arrange
        final List<Student> randomStudents = base.createRandomStudentList();
        final List<Student> storageStudents = randomStudents;
        final List<Student> expectedStudents = storageStudents;

        when(
          () => base.storageBrokerMock.selectAllStudentsAsync(),
        ).thenAnswer((_) async => storageStudents);

        // Act
        final List<Student> actualStudents = await base.studentService
            .retrieveAllStudentsAsync();

        // Assert
        expect(actualStudents, equals(expectedStudents));
        verify(() => base.storageBrokerMock.selectAllStudentsAsync()).called(1);
        verifyNoMoreInteractions(base.storageBrokerMock);
        verifyNoMoreInteractions(base.loggingBrokerMock);
      });

      test('GIVEN no students in storage '
          'WHEN retrieveAllStudentsAsync is called '
          'THEN it should return an empty list', () async {
        // Arrange
        final List<Student> emptyStudents = [];

        when(
          () => base.storageBrokerMock.selectAllStudentsAsync(),
        ).thenAnswer((_) async => emptyStudents);

        // Act
        final List<Student> actualStudents = await base.studentService
            .retrieveAllStudentsAsync();

        // Assert
        expect(actualStudents, isEmpty);
        verify(() => base.storageBrokerMock.selectAllStudentsAsync()).called(1);
        verifyNoMoreInteractions(base.storageBrokerMock);
        verifyNoMoreInteractions(base.loggingBrokerMock);
      });
    });

    group('Dependency Exceptions |', () {
      test(
        'GIVEN the storage broker throws an exception '
        'WHEN retrieveAllStudentsAsync is called '
        'THEN it should throw StudentDependencyException and log the error',
        () async {
          // Arrange
          final storageException = Exception('Storage unavailable.');

          when(
            () => base.storageBrokerMock.selectAllStudentsAsync(),
          ).thenThrow(storageException);

          // Act
          Future<List<Student>> retrieveAllAction() =>
              base.studentService.retrieveAllStudentsAsync();

          // Assert
          await expectLater(
            retrieveAllAction,
            throwsA(
              isA<StudentDependencyException>().having(
                (e) => e.innerException,
                'innerException',
                isA<FailedStudentDependencyException>(),
              ),
            ),
          );
          verify(
            () => base.storageBrokerMock.selectAllStudentsAsync(),
          ).called(1);
          verify(
            () => base.loggingBrokerMock.logError(
              any(),
              message: any(named: 'message'),
            ),
          ).called(1);
          verifyNoMoreInteractions(base.storageBrokerMock);
        },
      );
    });
  });
}
