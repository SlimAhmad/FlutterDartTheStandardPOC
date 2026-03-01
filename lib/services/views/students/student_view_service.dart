import 'package:hello_world/brokers/dateTimes/i_date_time_broker.dart';
import 'package:hello_world/brokers/loggings/i_logging_broker.dart';
import 'package:hello_world/models/foundations/students/student_exceptions.dart';
import 'package:hello_world/models/views/students/exceptions/student_view_exceptions.dart';
import 'package:hello_world/models/views/students/student_mapping_view.dart';
import 'package:hello_world/models/views/students/student_view.dart';
import 'package:hello_world/services/foundations/customers/student_service.dart';
import 'package:hello_world/services/views/students/i_student_view_service.dart';

part 'parts/student_view_service_exceptions.dart';
part 'parts/student_view_service_validations.dart';

class StudentViewService implements IStudentViewService {
  final StudentService studentService;
  final IDateTimeBroker dateTimeBroker;
  final ILoggingBroker loggingBroker;

  StudentViewService({
    required this.studentService,
    required this.dateTimeBroker,
    required this.loggingBroker,
  });

  @override
  Future<StudentView> addStudentViewAsync(StudentView student) => tryCatch(
    () async {
      validateStudentView(student);

      final mappedStudent = await student.toNewStudent(dateTimeBroker);

      final addedStudent = await studentService.addStudentAsync(mappedStudent);

      return addedStudent.toView();
    },
  );

  @override
  Future<List<StudentView>> retrieveAllStudentViewsAsync() =>
      tryCatchList(() async {
        final students = await studentService.retrieveAllStudentsAsync();
        return students.map((student) => student.toView()).toList();
      });

  @override
  Future<StudentView> retrieveStudentViewByIdAsync(String studentId) =>
      tryCatch(() async {
        validateStudentId(studentId);

        final student = await studentService.retrieveStudentByIdAsync(
          studentId,
        );

        return student.toView();
      });

  @override
  Future<StudentView> modifyStudentViewAsync(StudentView student) =>
      tryCatch(() async {
        validateStudentView(student);

        final mappedStudent = await student.toModifiedStudent(dateTimeBroker);

        final modifiedStudent = await studentService.modifyStudentAsync(
          mappedStudent,
        );

        return modifiedStudent.toView();
      });
}
