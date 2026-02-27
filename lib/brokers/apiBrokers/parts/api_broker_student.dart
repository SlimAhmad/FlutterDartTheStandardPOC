part of "../api_broker.dart";

class ApibrokerStudent extends ApiBroker implements IApibrokerStudent {

    ApibrokerStudent({
      required super.httpClient,
      required super.preferenceBroker,
    });

   String relativeUrl = "/students";

  @override
  Future<Student> postStudentAsync(Student student) async {
    return await postAsync<Student>(
      "/students",
      student,
      (json) => Student.fromJson(json),
    );
  }

   @override
   Future<List<Student>> getAllStudentsAsync(String oDataQuery) async {
    
    if (oDataQuery.isEmpty && oDataQuery.isNotEmpty) {
      relativeUrl += "?$oDataQuery";
    }

    return await getAsync<List<Student>>(
      relativeUrl,
      (jsonList) => (jsonList as List)
          .map((json) => Student.fromJson(json as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Future<Student> getStudentByIdAsync(String studentId) async {
    return await getAsync<Student>(
      "/students/$studentId",
      (json) => Student.fromJson(json),
    );
  }

  @override
  Future<Student> putStudentAsync(Student student) async {
    return await putAsync<Student>(
      "/students/${student.id}",
      student,
      (json) => Student.fromJson(json),
    );
  }

  @override
  Future<Student> deleteStudentByIdAsync(String studentId) async {
    return await deleteAsync<Student>(
      "/students/$studentId",
      (json) => Student.fromJson(json),
    );
  }
}