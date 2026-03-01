import 'package:hello_world/models/foundations/students/student.dart';

abstract class IStudentService {
  Future<Student> addStudentAsync(Student? student);
  Future<Student> retrieveStudentByIdAsync(String studentId);
  Future<List<Student>> retrieveAllStudentsAsync();
  Future<Student> modifyStudentAsync(Student? student);
  Future<Student> removeStudentByIdAsync(String studentId);
}
