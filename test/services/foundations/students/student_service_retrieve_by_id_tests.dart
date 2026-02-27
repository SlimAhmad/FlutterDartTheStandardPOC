import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world/models/students/student.dart';
import 'package:hello_world/models/students/student_exceptions.dart';
import 'package:mocktail/mocktail.dart';

import 'student_service_test_base.dart';

void runRetrieveStudentByIdTests(StudentServiceTestBase base) {
  group('retrieveStudentByIdAsync —', () {
    group('retrieve byId |', () {
      test(
        'GIVEN a valid studentId that exists in storage '
        'WHEN retrieveStudentByIdAsync is called '
        'THEN it should return the matching student',
        () async {
          // Arrange
          final Student randomStudent = base.createRandomStudent();
          final String inputStudentId = randomStudent.id;
          final Student storageStudent = randomStudent;
          final Student expectedStudent = storageStudent;

          when(() =>
                  base.storageBrokerMock.selectStudentByIdAsync(inputStudentId))
              .thenAnswer((_) async => storageStudent);

          // Act
          final Student actualStudent =
              await base.studentService.retrieveStudentByIdAsync(inputStudentId);

          // Assert
          expect(actualStudent, equals(expectedStudent));
          verify(() => base.storageBrokerMock
              .selectStudentByIdAsync(inputStudentId)).called(1);
          verifyNoMoreInteractions(base.storageBrokerMock);
          verifyNoMoreInteractions(base.loggingBrokerMock);
        },
      );
    });

    group('Validation |', () {
      test(
        'GIVEN an empty studentId '
        'WHEN retrieveStudentByIdAsync is called '
        'THEN it should throw StudentValidationException',
        () async {
          // Arrange
          const String emptyStudentId = '';

          // Act
          Future<Student> retrieveAction() =>
              base.studentService.retrieveStudentByIdAsync(emptyStudentId);

          // Assert
          await expectLater(
            retrieveAction,
            throwsA(
              isA<StudentValidationException>().having(
                (e) => e.innerException,
                'innerException',
                isA<InvalidStudentException>(),
              ),
            ),
          );
          verifyNever(
              () => base.storageBrokerMock.selectStudentByIdAsync(any()));
        },
      );

      test(
        'GIVEN a valid studentId that does NOT exist in storage '
        'WHEN retrieveStudentByIdAsync is called '
        'THEN it should throw StudentValidationException wrapping NotFoundStudentException',
        () async {
          // Arrange
          final String nonExistentId = base.randomId();

          when(() =>
                  base.storageBrokerMock.selectStudentByIdAsync(nonExistentId))
              .thenAnswer((_) async => null);

          // Act
          Future<Student> retrieveAction() =>
              base.studentService.retrieveStudentByIdAsync(nonExistentId);

          // Assert
          await expectLater(
            retrieveAction,
            throwsA(
              isA<StudentValidationException>().having(
                (e) => e.innerException,
                'innerException',
                isA<NotFoundStudentException>(),
              ),
            ),
          );
          verify(() => base.storageBrokerMock
              .selectStudentByIdAsync(nonExistentId)).called(1);
          verifyNoMoreInteractions(base.storageBrokerMock);
        },
      );
    });

    group('Dependency Exceptions |', () {
      test(
        'GIVEN the storage broker throws an exception '
        'WHEN retrieveStudentByIdAsync is called '
        'THEN it should throw StudentDependencyException',
        () async {
          // Arrange
          final String randomStudentId = base.randomId();
          final storageException = Exception('Database timeout.');

          when(() => base.storageBrokerMock
                  .selectStudentByIdAsync(randomStudentId))
              .thenThrow(storageException);

          // Act
          Future<Student> retrieveAction() =>
              base.studentService.retrieveStudentByIdAsync(randomStudentId);

          // Assert
          await expectLater(
            retrieveAction,
            throwsA(isA<StudentDependencyException>()),
          );
          verify(() => base.storageBrokerMock
              .selectStudentByIdAsync(randomStudentId)).called(1);

          verify(() => base.loggingBrokerMock
              .logError(any(), message: any(named: 'message'))).called(1);
              
          verifyNoMoreInteractions(base.storageBrokerMock);
        },
      );
    });
  });
}
