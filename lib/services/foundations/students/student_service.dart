import 'package:hello_world/brokers/loggings/i_logging_broker.dart';
import 'package:hello_world/brokers/storages/i_storage_broker.dart';

import '../../../models/students/student.dart';
import '../../../models/students/student_exceptions.dart';
import 'i_student_service.dart';

part 'student_service_validations.dart';
part 'student_service_exceptions.dart';

class StudentService implements IStudentService {
  final IStorageBroker storageBroker;
  final ILoggingBroker loggingBroker;

  StudentService({
    required this.storageBroker,
    required this.loggingBroker,
  });

  // ─── ADD ──────────────────────────────────────────────────────────────────

  @override
  Future<Student> addStudentAsync(Student? student) =>
      tryCatchService(() async {
        validateStudentOnAdd(student);

        return tryCatch(() => storageBroker.insertStudentAsync(student!));
      });

  // ─── RETRIEVE BY ID ───────────────────────────────────────────────────────

  @override
  Future<Student> retrieveStudentByIdAsync(String studentId) =>
      tryCatchService(() async {
        validateStudentId(studentId);

        final Student? storageStudent = await tryCatch(
          () => storageBroker.selectStudentByIdAsync(studentId),
        );

        validateStorageStudent(storageStudent, studentId);
        return storageStudent!;
      });

  // ─── RETRIEVE ALL ─────────────────────────────────────────────────────────

  @override
  Future<List<Student>> retrieveAllStudentsAsync() =>
      tryCatchService(() async {
        return tryCatch(() => storageBroker.selectAllStudentsAsync());
      });

  // ─── MODIFY ───────────────────────────────────────────────────────────────

  @override
  Future<Student> modifyStudentAsync(Student? student) =>
      tryCatchService(() async {
        validateStudentOnModify(student);

        return tryCatch(() => storageBroker.updateStudentAsync(student!));
      });

  // ─── REMOVE ───────────────────────────────────────────────────────────────

  @override
  Future<Student> removeStudentByIdAsync(String studentId) =>
      tryCatchService(() async {
        validateStudentId(studentId);

        final Student? storageStudent = await tryCatch(
          () => storageBroker.selectStudentByIdAsync(studentId),
        );

        validateStorageStudent(storageStudent, studentId);

        return tryCatch(
          () => storageBroker.deleteStudentAsync(storageStudent!),
        );
      });
}
