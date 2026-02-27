import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world/models/students/student.dart';
import 'package:hello_world/models/students/student_exceptions.dart';
import 'package:mocktail/mocktail.dart';

import 'student_service_test_base.dart';

void runRemoveStudentByIdTests(StudentServiceTestBase base) {
  group('removeStudentByIdAsync —', () {
    // ─── Happy Path ──────────────────────────────────────────────────────────

    group('Happy Path |', () {
      test(
        'GIVEN a valid studentId that exists '
        'WHEN removeStudentByIdAsync is called '
        'THEN it should look up, delete and return the deleted student',
        () async {
          // Arrange
          final Student randomStudent = base.createRandomStudent();
          final String inputStudentId = randomStudent.id;
          final Student storageStudent = randomStudent;
          final Student deletedStudent = storageStudent;
          final Student expectedStudent = deletedStudent;

          when(() => base.storageBrokerMock
                  .selectStudentByIdAsync(inputStudentId))
              .thenAnswer((_) async => storageStudent);

          when(() => base.storageBrokerMock.deleteStudentAsync(storageStudent))
              .thenAnswer((_) async => deletedStudent);

          // Act
          final Student actualStudent =
              await base.studentService.removeStudentByIdAsync(inputStudentId);

          // Assert
          expect(actualStudent, equals(expectedStudent));

          verify(() => base.storageBrokerMock
              .selectStudentByIdAsync(inputStudentId)).called(1);
          verify(() => base.storageBrokerMock.deleteStudentAsync(storageStudent))
              .called(1);
          verifyNoMoreInteractions(base.storageBrokerMock);
          verifyNoMoreInteractions(base.loggingBrokerMock);
        },
      );
    });

    // ─── Validation ──────────────────────────────────────────────────────────

    group('Validation |', () {
      test(
        'GIVEN an empty studentId '
        'WHEN removeStudentByIdAsync is called '
        'THEN it should throw StudentValidationException',
        () async {
          // Arrange
          const String emptyStudentId = '';

          // Act
          Future<Student> removeAction() =>
              base.studentService.removeStudentByIdAsync(emptyStudentId);

          // Assert
          await expectLater(
            removeAction,
            throwsA(isA<StudentValidationException>()),
          );
          verifyNever(
              () => base.storageBrokerMock.selectStudentByIdAsync(any()));
          verifyNever(
              () => base.storageBrokerMock.deleteStudentAsync(any()));
        },
      );

      test(
        'GIVEN a studentId that does not exist in storage '
        'WHEN removeStudentByIdAsync is called '
        'THEN it should throw StudentValidationException wrapping NotFoundStudentException',
        () async {
          // Arrange
          final String nonExistentId = base.randomId();

          when(() => base.storageBrokerMock
                  .selectStudentByIdAsync(nonExistentId))
              .thenAnswer((_) async => null);

          // Act
          Future<Student> removeAction() =>
              base.studentService.removeStudentByIdAsync(nonExistentId);

          // Assert
          await expectLater(
            removeAction,
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
          verifyNever(
              () => base.storageBrokerMock.deleteStudentAsync(any()));
          verifyNoMoreInteractions(base.storageBrokerMock);
        },
      );
    });

    // ─── Dependency ──────────────────────────────────────────────────────────

    group('Dependency Exceptions |', () {
      test(
        'GIVEN the storage broker throws during selectById '
        'WHEN removeStudentByIdAsync is called '
        'THEN it should throw StudentDependencyException and log the error',
        () async {
          // Arrange
          final String randomStudentId = base.randomId();
          final storageException = Exception('Read failure.');

          when(() => base.storageBrokerMock
                  .selectStudentByIdAsync(randomStudentId))
              .thenThrow(storageException);

          // Act
          Future<Student> removeAction() =>
              base.studentService.removeStudentByIdAsync(randomStudentId);

          // Assert
          await expectLater(
            removeAction,
            throwsA(isA<StudentDependencyException>()),
          );
          verify(() => base.storageBrokerMock
              .selectStudentByIdAsync(randomStudentId)).called(1);
          verify(() => base.loggingBrokerMock
              .logError(any(), message: any(named: 'message'))).called(1);
          verifyNever(
              () => base.storageBrokerMock.deleteStudentAsync(any()));
          verifyNoMoreInteractions(base.storageBrokerMock);
        },
      );

      test(
        'GIVEN the storage broker throws during delete '
        'WHEN removeStudentByIdAsync is called '
        'THEN it should throw StudentDependencyException and log the error',
        () async {
          // Arrange
          final Student randomStudent = base.createRandomStudent();
          final String inputStudentId = randomStudent.id;
          final storageException = Exception('Delete conflict.');

          when(() => base.storageBrokerMock
                  .selectStudentByIdAsync(inputStudentId))
              .thenAnswer((_) async => randomStudent);

          when(() => base.storageBrokerMock.deleteStudentAsync(randomStudent))
              .thenThrow(storageException);

          // Act
          Future<Student> removeAction() =>
              base.studentService.removeStudentByIdAsync(inputStudentId);

          // Assert
          await expectLater(
            removeAction,
            throwsA(isA<StudentDependencyException>()),
          );
          verify(() => base.storageBrokerMock
              .selectStudentByIdAsync(inputStudentId)).called(1);
          verify(() => base.storageBrokerMock.deleteStudentAsync(randomStudent))
              .called(1);
          verify(() => base.loggingBrokerMock
              .logError(any(), message: any(named: 'message'))).called(1);
          verifyNoMoreInteractions(base.storageBrokerMock);
        },
      );
    });
  });
}
