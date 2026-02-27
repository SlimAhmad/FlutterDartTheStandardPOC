import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world/models/students/student.dart';
import 'package:hello_world/models/students/student_exceptions.dart';
import 'package:mocktail/mocktail.dart';

import 'student_service_test_base.dart';

void runAddStudentDependencyTests(StudentServiceTestBase base) {
  group('addStudentAsync — Dependency Exceptions |', () {
    test(
      'GIVEN the storage broker throws a generic Exception '
      'WHEN addStudentAsync is called '
      'THEN it should throw StudentDependencyException wrapping FailedStudentDependencyException',
      () async {
        // Arrange
        final Student randomStudent = base.createRandomStudent();
        final storageException = Exception('Connection refused.');

        when(() => base.storageBrokerMock.insertStudentAsync(randomStudent))
            .thenThrow(storageException);

        // Act
        Future<Student> addAction() =>
            base.studentService.addStudentAsync(randomStudent);

        // Assert
        await expectLater(
          addAction,
          throwsA(
            isA<StudentDependencyException>().having(
              (e) => e.innerException,
              'innerException',
              isA<FailedStudentDependencyException>(),
            ),
          ),
        );
        verify(() => base.storageBrokerMock.insertStudentAsync(randomStudent))
            .called(1);
        verify(
          () => base.loggingBrokerMock.logError(
            any(),
            message: any(named: 'message'),
          ),
        ).called(1);
        verifyNoMoreInteractions(base.storageBrokerMock);
      },
    );

    test(
      'GIVEN the storage broker throws FailedStudentRequestException '
      'WHEN addStudentAsync is called '
      'THEN it should throw StudentDependencyException wrapping FailedStudentRequestException',
      () async {
        // Arrange
        final Student randomStudent = base.createRandomStudent();
        final requestException = FailedStudentRequestException(
          innerException: Exception('HTTP 503 Service Unavailable.'),
        );

        when(() => base.storageBrokerMock.insertStudentAsync(randomStudent))
            .thenThrow(requestException);

        // Act
        Future<Student> addAction() =>
            base.studentService.addStudentAsync(randomStudent);

        // Assert
        await expectLater(
          addAction,
          throwsA(
            isA<StudentDependencyException>().having(
              (e) => e.innerException,
              'innerException',
              isA<FailedStudentRequestException>(),
            ),
          ),
        );
        verify(() => base.storageBrokerMock.insertStudentAsync(randomStudent))
            .called(1);
        verify(
          () => base.loggingBrokerMock.logError(
            any(),
            message: any(named: 'message'),
          ),
        ).called(1);
        verifyNoMoreInteractions(base.storageBrokerMock);
      },
    );

    test(
      'GIVEN the storage broker throws FailedStudentConfigurationException '
      'WHEN addStudentAsync is called '
      'THEN it should throw StudentDependencyException wrapping FailedStudentConfigurationException '
      'AND log a critical error',
      () async {
        // Arrange
        final Student randomStudent = base.createRandomStudent();
        final configException = FailedStudentConfigurationException(
          innerException: Exception('Missing API key.'),
        );

        when(() => base.storageBrokerMock.insertStudentAsync(randomStudent))
            .thenThrow(configException);

        // Act
        Future<Student> addAction() =>
            base.studentService.addStudentAsync(randomStudent);

        // Assert
        await expectLater(
          addAction,
          throwsA(
            isA<StudentDependencyException>().having(
              (e) => e.innerException,
              'innerException',
              isA<FailedStudentConfigurationException>(),
            ),
          ),
        );
        verify(() => base.storageBrokerMock.insertStudentAsync(randomStudent))
            .called(1);
        verify(
          () => base.loggingBrokerMock.logCritical(
            any(),
            message: any(named: 'message'),
          ),
        ).called(1);
        verifyNoMoreInteractions(base.storageBrokerMock);
      },
    );

    test(
      'GIVEN the storage broker throws LockedUserStudentException '
      'WHEN addStudentAsync is called '
      'THEN it should throw StudentDependencyValidationException wrapping LockedUserStudentException',
      () async {
        // Arrange
        final Student randomStudent = base.createRandomStudent();
        final lockedException = LockedUserStudentException(
          innerException: Exception('Record locked by another user.'),
        );

        when(() => base.storageBrokerMock.insertStudentAsync(randomStudent))
            .thenThrow(lockedException);

        // Act
        Future<Student> addAction() =>
            base.studentService.addStudentAsync(randomStudent);

        // Assert
        await expectLater(
          addAction,
          throwsA(
            isA<StudentDependencyValidationException>().having(
              (e) => e.innerException,
              'innerException',
              isA<LockedUserStudentException>(),
            ),
          ),
        );
        verify(() => base.storageBrokerMock.insertStudentAsync(randomStudent))
            .called(1);
        verifyNoMoreInteractions(base.storageBrokerMock);
      },
    );

    test(
      'GIVEN an unexpected service-level exception occurs '
      'WHEN addStudentAsync is called '
      'THEN it should throw StudentDependencyException wrapping FailedStudentDependencyException',
      () async {
        // Arrange
        final Student randomStudent = base.createRandomStudent();
        final unexpectedException = Exception('Unhandled null reference.');

        // Wrap in FailedStudentServiceException to simulate a service fault
        // that bypasses dependency handling
        when(() => base.storageBrokerMock.insertStudentAsync(randomStudent))
            .thenAnswer((_) async {
          throw FailedStudentServiceException(
            innerException: unexpectedException,
          );
        });

        // Act
        Future<Student> addAction() =>
            base.studentService.addStudentAsync(randomStudent);

        // Assert
        await expectLater(
          addAction,
          throwsA(
            isA<StudentDependencyException>().having(
              (e) => e.innerException,
              'innerException',
              isA<FailedStudentDependencyException>(),
            ),
          ),
        );
        verify(() => base.storageBrokerMock.insertStudentAsync(randomStudent))
            .called(1);
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
}
