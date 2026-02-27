import '../../models/students/student.dart';

abstract class IStorageBroker {
  Future<Student> insertStudentAsync(Student student);
  Future<Student?> selectStudentByIdAsync(String studentId);
  Future<List<Student>> selectAllStudentsAsync();
  Future<Student> updateStudentAsync(Student student);
  Future<Student> deleteStudentAsync(Student student);
}
