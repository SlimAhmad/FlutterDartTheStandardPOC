import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world/models/students/student.dart';
import 'package:hello_world/models/students/student_exceptions.dart';
import 'package:mocktail/mocktail.dart';

import 'student_service_test_base.dart';

void runModifyStudentTests(StudentServiceTestBase base) {
  group('modifyStudentAsync —', () {

    group('modify |', () {
      test(
        'GIVEN a valid modified student '
        'WHEN modifyStudentAsync is called '
        'THEN it should update via the broker and return the updated student',
        () async {
          // Arrange
          final Student randomStudent = base.createRandomModifiedStudent();
          final Student inputStudent = randomStudent;
          final Student storageStudent = randomStudent;
          final Student expectedStudent = storageStudent;

          when(() => base.storageBrokerMock.updateStudentAsync(inputStudent))
              .thenAnswer((_) async => storageStudent);

          // Act
          final Student actualStudent =
              await base.studentService.modifyStudentAsync(inputStudent);

          // Assert
          expect(actualStudent, equals(expectedStudent));
          verify(() => base.storageBrokerMock.updateStudentAsync(inputStudent))
              .called(1);
          verifyNoMoreInteractions(base.storageBrokerMock);
          verifyNoMoreInteractions(base.loggingBrokerMock);
        },
      );
    });

    group('Validation |', () {
      test(
        'GIVEN a null student '
        'WHEN modifyStudentAsync is called '
        'THEN it should throw StudentValidationException wrapping InvalidStudentException',
        () async {
          // Arrange
          const Student? nullStudent = null;

          // Act
          Future<Student> modifyAction() =>
              base.studentService.modifyStudentAsync(nullStudent);

          // Assert
          await expectLater(
            modifyAction,
            throwsA(
              isA<StudentValidationException>().having(
                (e) => e.innerException,
                'innerException',
                isA<InvalidStudentException>(),
              ),
            ),
          );
          verifyNever(() => base.storageBrokerMock.updateStudentAsync(any()));
        },
      );

      test(
        'GIVEN a student with an empty Id '
        'WHEN modifyStudentAsync is called '
        'THEN it should throw StudentValidationException with Id error',
        () async {
          // Arrange
          final Student invalidStudent =
              base.createRandomModifiedStudent().copyWith(id: '');

          // Act
          Future<Student> modifyAction() =>
              base.studentService.modifyStudentAsync(invalidStudent);

          // Assert
          await expectLater(
            modifyAction,
            throwsA(isA<StudentValidationException>()),
          );
          verifyNever(() => base.storageBrokerMock.updateStudentAsync(any()));
        },
      );

      test(
        'GIVEN a student where UpdatedDate is NOT after CreatedDate '
        'WHEN modifyStudentAsync is called '
        'THEN it should throw StudentValidationException with UpdatedDate error',
        () async {
          // Arrange
          final now = DateTime.now();
          final Student invalidStudent = base.createRandomStudent().copyWith(
            createdDate: now,
            updatedDate: now, // must be strictly after on modify
          );

          // Act
          Future<Student> modifyAction() =>
              base.studentService.modifyStudentAsync(invalidStudent);

          // Assert
          await expectLater(
            modifyAction,
            throwsA(
              isA<StudentValidationException>().having(
                (e) => e.innerException,
                'innerException',
                isA<InvalidStudentException>().having(
                  (e) => e.data.containsKey('UpdatedDate'),
                  'has UpdatedDate error',
                  isTrue,
                ),
              ),
            ),
          );
          verifyNever(() => base.storageBrokerMock.updateStudentAsync(any()));
        },
      );

      test(
        'GIVEN a student with an invalid email '
        'WHEN modifyStudentAsync is called '
        'THEN it should throw StudentValidationException with Email error',
        () async {
          // Arrange
          final Student invalidStudent =
              base.createRandomModifiedStudent().copyWith(email: 'bad-email');

          // Act
          Future<Student> modifyAction() =>
              base.studentService.modifyStudentAsync(invalidStudent);

          // Assert
          await expectLater(
            modifyAction,
            throwsA(isA<StudentValidationException>()),
          );
          verifyNever(() => base.storageBrokerMock.updateStudentAsync(any()));
        },
      );
    });

    group('Dependency Exceptions |', () {
      test(
        'GIVEN the storage broker throws during update '
        'WHEN modifyStudentAsync is called '
        'THEN it should throw StudentDependencyException and log the error',
        () async {
          // Arrange
          final Student randomStudent = base.createRandomModifiedStudent();
          final storageException = Exception('Write conflict.');

          when(() => base.storageBrokerMock.updateStudentAsync(randomStudent))
              .thenThrow(storageException);

          // Act
          Future<Student> modifyAction() =>
              base.studentService.modifyStudentAsync(randomStudent);

          // Assert
          await expectLater(
            modifyAction,
            throwsA(isA<StudentDependencyException>()),
          );
          verify(() => base.storageBrokerMock.updateStudentAsync(randomStudent))
              .called(1);
          verify(() => base.loggingBrokerMock
              .logError(any(), message: any(named: 'message'))).called(1);
          verifyNoMoreInteractions(base.storageBrokerMock);
        },
      );

      test(
        'GIVEN the storage broker throws LockedUserStudentException '
        'WHEN modifyStudentAsync is called '
        'THEN it should throw StudentDependencyValidationException wrapping LockedUserStudentException',
        () async {
          // Arrange
          final Student randomStudent = base.createRandomModifiedStudent();
          final lockedException = LockedUserStudentException(
            innerException: Exception('Record locked.'),
          );

          when(() => base.storageBrokerMock.updateStudentAsync(randomStudent))
              .thenThrow(lockedException);

          // Act
          Future<Student> modifyAction() =>
              base.studentService.modifyStudentAsync(randomStudent);

          // Assert
          await expectLater(
            modifyAction,
            throwsA(
              isA<StudentDependencyValidationException>().having(
                (e) => e.innerException,
                'innerException',
                isA<LockedUserStudentException>(),
              ),
            ),
          );
          verify(() => base.storageBrokerMock.updateStudentAsync(randomStudent))
              .called(1);
          verifyNoMoreInteractions(base.storageBrokerMock);
        },
      );
    });
  });
}
