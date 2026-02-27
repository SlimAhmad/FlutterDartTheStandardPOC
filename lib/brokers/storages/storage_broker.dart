import '../../models/students/student.dart';
import 'i_storage_broker.dart';

class StorageBroker implements IStorageBroker {
  final Map<String, Student> _store = {};

  @override
  Future<Student> insertStudentAsync(Student student) async {
    _store[student.id] = student;
    return student;
  }

  @override
  Future<Student?> selectStudentByIdAsync(String studentId) async {
    return _store[studentId];
  }

  @override
  Future<List<Student>> selectAllStudentsAsync() async {
    return _store.values.toList();
  }

  @override
  Future<Student> updateStudentAsync(Student student) async {
    _store[student.id] = student;
    return student;
  }

  @override
  Future<Student> deleteStudentAsync(Student student) async {
    _store.remove(student.id);
    return student;
  }
}
