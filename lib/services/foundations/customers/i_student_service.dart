import 'package:hello_world/models/students/student.dart';

abstract class IStudentService {
      Future<Student> addStudentAsync(Student student);
      Future<List<Student>> retrieveAllStudentsAsync();
      Future<Student> retrieveStudentByIdAsync(String studentId);
      Future<Student> modifyStudentAsync(Student student);
}