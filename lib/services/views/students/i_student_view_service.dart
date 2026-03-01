import 'package:hello_world/models/views/students/student_view.dart';

abstract class IStudentViewService {
  Future<StudentView> addStudentViewAsync(StudentView student);
  Future<List<StudentView>> retrieveAllStudentViewsAsync();
  Future<StudentView> retrieveStudentViewByIdAsync(String studentId);
  Future<StudentView> modifyStudentViewAsync(StudentView student);
}
