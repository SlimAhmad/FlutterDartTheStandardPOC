import 'package:faker/faker.dart';
import 'package:hello_world/brokers/loggings/i_logging_broker.dart';
import 'package:hello_world/brokers/storages/i_storage_broker.dart';
import 'package:hello_world/models/students/student.dart';
import 'package:hello_world/services/foundations/students/i_student_service.dart';
import 'package:hello_world/services/foundations/students/student_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

class MockStorageBroker extends Mock implements IStorageBroker {}
class MockLoggingBroker extends Mock implements ILoggingBroker {}

class StudentServiceTestBase {
  late MockStorageBroker storageBrokerMock;
  late MockLoggingBroker loggingBrokerMock;
  late IStudentService studentService;

  final _faker = Faker();
  final _uuid = const Uuid();

  void setUpStudentServiceTests() {
    storageBrokerMock = MockStorageBroker();
    loggingBrokerMock = MockLoggingBroker();

    registerFallbackValue(
      Student(
        id: '',
        name: '',
        email: '',
        createdDate: DateTime.now(),
        updatedDate: DateTime.now(),
      ),
    );
    registerFallbackValue(Exception('test'));

    studentService = StudentService(
      storageBroker: storageBrokerMock,
      loggingBroker: loggingBrokerMock,
    );

    when(() => loggingBrokerMock.logError(any(), message: any(named: 'message')))
        .thenReturn(null);

    when(() => loggingBrokerMock.logCritical(any(), message: any(named: 'message')))
        .thenReturn(null);

    when(() => loggingBrokerMock.logInformation(any())).thenReturn(null);
    
    when(() => loggingBrokerMock.logWarning(any())).thenReturn(null);
  }

  String randomId() =>
     _uuid.v4();

  String randomName() => 
    _faker.person.name();

  String randomEmail() => 
    _faker.internet.email();

  DateTime randomPastDate() =>
      DateTime.now().subtract(Duration(days: _faker.randomGenerator.integer(365, min: 1)));

  Student createRandomStudent() {
    final now = DateTime.now();
    return Student(
      id: randomId(),
      name: randomName(),
      email: randomEmail(),
      createdDate: now,
      updatedDate: now,
    );
  }

  Student createRandomModifiedStudent() {
    final created = randomPastDate();
    final updated = created.add(const Duration(hours: 1));
    return Student(
      id: randomId(),
      name: randomName(),
      email: randomEmail(),
      createdDate: created,
      updatedDate: updated,
    );
  }

  List<Student> createRandomStudentList({int count = 3}) =>
      List.generate(count, (_) => createRandomStudent());
}
