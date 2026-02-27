part of "../i_api_broker.dart";

abstract class IApibrokerStudent {
  Future<Student> postStudentAsync(Student student);
  Future<List<Student>> getAllStudentsAsync(String oDataQuery);
  Future<Student> getStudentByIdAsync(String studentId);
  Future<Student> putStudentAsync(Student student);
  Future<Student> deleteStudentByIdAsync(String studentId);
}