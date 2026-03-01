import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world/models/foundations/students/student.dart';
import 'package:hello_world/models/foundations/students/student_exceptions.dart';
import 'package:mocktail/mocktail.dart';

import 'student_service_test_base.dart';

void runAddStudentDependencyTests(StudentServiceTestBase base) {
  group('addStudentAsync — Dependency Exceptions |', () {
    test(
      'GIVEN the storage broker throws a generic Exception '
      'WHEN addStudentAsync is called '
      'THEN it should throw StudentDependencyException wrapping FailedStudentDependencyException',
      () async {
        // given
        final Student randomStudent = base.createRandomStudent();
        final storageException = Exception('Connection refused.');

        when(
          () => base.storageBrokerMock.insertStudentAsync(randomStudent),
        ).thenThrow(storageException);

        // when
        Future<Student> addAction() =>
            base.studentService.addStudentAsync(randomStudent);

        // then
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
        verify(
          () => base.storageBrokerMock.insertStudentAsync(randomStudent),
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

    test(
      'GIVEN the storage broker throws FailedStudentRequestException '
      'WHEN addStudentAsync is called '
      'THEN it should throw StudentDependencyException wrapping FailedStudentRequestException',
      () async {
        // given
        final Student randomStudent = base.createRandomStudent();
        final requestException = FailedStudentRequestException(
          innerException: Exception('HTTP 503 Service Unavailable.'),
        );

        when(
          () => base.storageBrokerMock.insertStudentAsync(randomStudent),
        ).thenThrow(requestException);

        // when
        Future<Student> addAction() =>
            base.studentService.addStudentAsync(randomStudent);

        // then
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
        verify(
          () => base.storageBrokerMock.insertStudentAsync(randomStudent),
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

    test('GIVEN the storage broker throws FailedStudentConfigurationException '
        'WHEN addStudentAsync is called '
        'THEN it should throw StudentDependencyException wrapping FailedStudentConfigurationException '
        'AND log a critical error', () async {
      // given
      final Student randomStudent = base.createRandomStudent();
      final configException = FailedStudentConfigurationException(
        innerException: Exception('Missing API key.'),
      );

      when(
        () => base.storageBrokerMock.insertStudentAsync(randomStudent),
      ).thenThrow(configException);

      // when
      Future<Student> addAction() =>
          base.studentService.addStudentAsync(randomStudent);

      // then
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
      verify(
        () => base.storageBrokerMock.insertStudentAsync(randomStudent),
      ).called(1);
      verify(
        () => base.loggingBrokerMock.logCritical(
          any(),
          message: any(named: 'message'),
        ),
      ).called(1);
      verifyNoMoreInteractions(base.storageBrokerMock);
    });

    test(
      'GIVEN the storage broker throws LockedUserStudentException '
      'WHEN addStudentAsync is called '
      'THEN it should throw StudentDependencyValidationException wrapping LockedUserStudentException',
      () async {
        // given
        final Student randomStudent = base.createRandomStudent();
        final lockedException = LockedUserStudentException(
          innerException: Exception('Record locked by another user.'),
        );

        when(
          () => base.storageBrokerMock.insertStudentAsync(randomStudent),
        ).thenThrow(lockedException);

        // when
        Future<Student> addAction() =>
            base.studentService.addStudentAsync(randomStudent);

        // then
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
        verify(
          () => base.storageBrokerMock.insertStudentAsync(randomStudent),
        ).called(1);
        verifyNoMoreInteractions(base.storageBrokerMock);
      },
    );

    test(
      'GIVEN an unexpected service-level exception occurs '
      'WHEN addStudentAsync is called '
      'THEN it should throw StudentDependencyException wrapping FailedStudentDependencyException',
      () async {
        // given
        final Student randomStudent = base.createRandomStudent();
        final unexpectedException = Exception('Unhandled null reference.');

        when(
          () => base.storageBrokerMock.insertStudentAsync(randomStudent),
        ).thenAnswer((_) async {
          throw FailedStudentServiceException(
            innerException: unexpectedException,
          );
        });

        // when
        Future<Student> addAction() =>
            base.studentService.addStudentAsync(randomStudent);

        // then
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
        verify(
          () => base.storageBrokerMock.insertStudentAsync(randomStudent),
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
}
