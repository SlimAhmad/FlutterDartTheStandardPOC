import 'package:hello_world/brokers/apiBrokers/api_broker.dart';
import 'package:hello_world/brokers/loggings/i_logging_broker.dart';
import 'package:hello_world/brokers/storages/i_storage_broker.dart';
import 'package:hello_world/models/foundations/students/student.dart';
import 'package:hello_world/models/foundations/students/student_exceptions.dart';
import 'package:hello_world/services/foundations/customers/i_student_service.dart';
import 'package:hello_world/services/foundations/customers/student_service.dart';
import 'package:http_exception/http_exception.dart';

part 'parts/student_service_exceptions.dart';
part 'parts/student_service_validations.dart';

class StudentService implements IStudentService {
   final ApibrokerStudent apibrokerStudent;
   final IStorageBroker storageBroker;
   final ILoggingBroker loggingBroker;
   
  StudentService({
    required this.apibrokerStudent, 
    required this.storageBroker,
    required this.loggingBroker});

  @override
  Future<Student> addStudentAsync(Student student) =>
  tryCatch(() async {
    validateStudentOnAdd(student);

    return apibrokerStudent.postStudentAsync(student);
  });

  @override
    Future<List<Student>> retrieveAllStudentsAsync() =>
    tryCatchList(() async {
      return apibrokerStudent.getAllStudentsAsync("");
    });

  @override
  Future<Student> retrieveStudentByIdAsync(String studentId) =>
  tryCatch(() async {
    validateStudentId(studentId);

    final Student student = 
      await apibrokerStudent.getStudentByIdAsync(studentId);

    validateStorageStudent(student, studentId);
    return student;
  });

  @override
  Future<Student> modifyStudentAsync(Student student)  =>
  tryCatch(() async {
    validateStudentOnModify(student);

    return apibrokerStudent.putStudentAsync(student);
  });
}