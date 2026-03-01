import 'package:hello_world/brokers/dateTimes/i_date_time_broker.dart';
import 'package:hello_world/models/foundations/students/student.dart';
import 'package:hello_world/models/views/students/student_view.dart';
import 'package:uuid/uuid.dart';

extension StudentViewCreateMapping on StudentView {
  Future<Student> toNewStudent(IDateTimeBroker broker) async {
    final now = await broker.getCurrentDateTimeOffsetAsync();

    return Student(
      id: const Uuid().v4(),
      name: name,
      email: email,
      createdDate: now,
      updatedDate: now,
    );
  }
}

extension StudentViewModifyMapping on StudentView {
  Future<Student> toModifiedStudent(IDateTimeBroker broker) async {
    final now = await broker.getCurrentDateTimeOffsetAsync();

    return Student(
      id: id,
      name: name,
      email: email,
      createdDate: createdDate,
      updatedDate: now,
    );
  }
}

extension StudentMapping on Student {
  StudentView toView() {
    return StudentView(
      id: id,
      name: name,
      email: email,
      createdDate: createdDate,
      updatedDate: updatedDate,
    );
  }
}
