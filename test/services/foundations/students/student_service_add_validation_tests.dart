import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world/models/students/student.dart';
import 'package:hello_world/models/students/student_exceptions.dart';
import 'package:mocktail/mocktail.dart';


import 'student_service_test_base.dart';

void runAddStudentValidationTests(StudentServiceTestBase base) {
  group('addStudentAsync — Validation |', () {

    test(
      'GIVEN a null student '
      'WHEN addStudentAsync is called '
      'THEN it should throw StudentValidationException wrapping InvalidStudentException',
      () async {
        // Arrange
        const Student? nullStudent = null;

        // Act
        Future<Student> addAction() =>
            base.studentService.addStudentAsync(nullStudent);

        // Assert
        await expectLater(
          addAction,
          throwsA(
            isA<StudentValidationException>().having(
              (e) => e.innerException,
              'innerException',
              isA<InvalidStudentException>(),
            ),
          ),
        );
        verifyNever(() => base.storageBrokerMock.insertStudentAsync(any()));
        verifyNoMoreInteractions(base.storageBrokerMock);
      },
    );

    test(
      'GIVEN a student with an empty Id '
      'WHEN addStudentAsync is called '
      'THEN it should throw StudentValidationException wrapping InvalidStudentException',
      () async {
        // Arrange
        final Student invalidStudent = base.createRandomStudent().copyWith(id: '');

        // Act
        Future<Student> addAction() =>
            base.studentService.addStudentAsync(invalidStudent);

        // Assert
        await expectLater(
          addAction,
          throwsA(
            isA<StudentValidationException>().having(
              (e) => e.innerException,
              'innerException',
              isA<InvalidStudentException>().having(
                (e) => e.data.containsKey('Id'),
                'has Id error',
                isTrue,
              ),
            ),
          ),
        );
        verifyNever(() => base.storageBrokerMock.insertStudentAsync(any()));
      },
    );

    test(
      'GIVEN a student with an empty Name '
      'WHEN addStudentAsync is called '
      'THEN it should throw StudentValidationException with Name error',
      () async {
        // Arrange
        final Student invalidStudent =
            base.createRandomStudent().copyWith(name: '');

        // Act
        Future<Student> addAction() =>
            base.studentService.addStudentAsync(invalidStudent);

        // Assert
        await expectLater(
          addAction,
          throwsA(
            isA<StudentValidationException>().having(
              (e) => e.innerException,
              'innerException',
              isA<InvalidStudentException>().having(
                (e) => e.data.containsKey('Name'),
                'has Name error',
                isTrue,
              ),
            ),
          ),
        );
        verifyNever(() => base.storageBrokerMock.insertStudentAsync(any()));
      },
    );

    test(
      'GIVEN a student with a whitespace-only Name '
      'WHEN addStudentAsync is called '
      'THEN it should throw StudentValidationException with Name error',
      () async {
        // Arrange
        final Student invalidStudent =
            base.createRandomStudent().copyWith(name: '   ');

        // Act
        Future<Student> addAction() =>
            base.studentService.addStudentAsync(invalidStudent);

        // Assert
        await expectLater(
          addAction,
          throwsA(isA<StudentValidationException>()),
        );
        verifyNever(() => base.storageBrokerMock.insertStudentAsync(any()));
      },
    );

    test(
      'GIVEN a student with an empty Email '
      'WHEN addStudentAsync is called '
      'THEN it should throw StudentValidationException with Email error',
      () async {
        // Arrange
        final Student invalidStudent =
            base.createRandomStudent().copyWith(email: '');

        // Act
        Future<Student> addAction() =>
            base.studentService.addStudentAsync(invalidStudent);

        // Assert
        await expectLater(
          addAction,
          throwsA(
            isA<StudentValidationException>().having(
              (e) => e.innerException,
              'innerException',
              isA<InvalidStudentException>().having(
                (e) => e.data.containsKey('Email'),
                'has Email error',
                isTrue,
              ),
            ),
          ),
        );
        verifyNever(() => base.storageBrokerMock.insertStudentAsync(any()));
      },
    );

    test(
      'GIVEN a student with an invalid Email format '
      'WHEN addStudentAsync is called '
      'THEN it should throw StudentValidationException with Email error',
      () async {
        // Arrange
        final Student invalidStudent =
            base.createRandomStudent().copyWith(email: 'not-an-email');

        // Act
        Future<Student> addAction() =>
            base.studentService.addStudentAsync(invalidStudent);

        // Assert
        await expectLater(
          addAction,
          throwsA(
            isA<StudentValidationException>().having(
              (e) => e.innerException,
              'innerException',
              isA<InvalidStudentException>().having(
                (e) => e.data['Email'],
                'Email errors',
                contains('Email is not a valid address.'),
              ),
            ),
          ),
        );
        verifyNever(() => base.storageBrokerMock.insertStudentAsync(any()));
      },
    );

    test(
      'GIVEN a student where UpdatedDate does not match CreatedDate '
      'WHEN addStudentAsync is called '
      'THEN it should throw StudentValidationException with UpdatedDate error',
      () async {
        // Arrange
        final now = DateTime.now();
        final Student invalidStudent = base.createRandomStudent().copyWith(
          createdDate: now,
          updatedDate: now.add(const Duration(hours: 1)), // must be equal on add
        );

        // Act
        Future<Student> addAction() =>
            base.studentService.addStudentAsync(invalidStudent);

        // Assert
        await expectLater(
          addAction,
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
        verifyNever(() => base.storageBrokerMock.insertStudentAsync(any()));
      },
    );
  });
}
