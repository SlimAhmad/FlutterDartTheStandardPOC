import 'dart:convert';
import 'package:hello_world/brokers/PreferenceBroker/preference_broker.dart';
import 'package:hello_world/brokers/apiBrokers/i_api_broker.dart';
import 'package:hello_world/models/movies/movie_list_response.dart';
import 'package:http/http.dart' as http;
import 'package:hello_world/models/students/student.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


part 'parts/api_broker_student.dart';
part 'parts/api_broker_movie_list.dart';

class ApiBroker implements IApiBroker {
  final http.Client _httpClient;
  final PreferenceBroker _preferenceBroker;
  final String _bearerToken = dotenv.env['TMDB_API_KEY'] ?? '';
  late String _baseUrl = dotenv.env['TMDB_BASE_URL'] ?? '';

  ApiBroker({
    required http.Client httpClient,
    required PreferenceBroker preferenceBroker,
  })  : _httpClient = httpClient,
        _preferenceBroker = preferenceBroker {
    _baseUrl = _getBaseUrl();
  }

  // ---------------------------------------------------------------
  // HTTP methods
  // ---------------------------------------------------------------

  Future<T> postAsync<T>(
    String relativeUrl,
    dynamic content,
    T Function(dynamic) fromJson,
  ) async {
    final uri = Uri.parse('$_baseUrl$relativeUrl');
    final response = await _httpClient.post(
      uri,
      headers: await _defaultHeaders(),
      body: jsonEncode(_toJson(content)),
    );
    _ensureSuccess(response);
    return fromJson(jsonDecode(response.body));
  }

  Future<T> getAsync<T>(
    String relativeUrl,
    T Function(dynamic) fromJson,
  ) async {
    final uri = Uri.parse('$_baseUrl$relativeUrl');
    final response = await _httpClient.get(
      uri,
      headers: await _defaultHeaders(),
    );
    _ensureSuccess(response);
    return fromJson(jsonDecode(response.body));
  }

  Future<T> putAsync<T>(
    String relativeUrl,
    dynamic content,
    T Function(dynamic) fromJson,
  ) async {
    final uri = Uri.parse('$_baseUrl$relativeUrl');
    final response = await _httpClient.put(
      uri,
      headers: await _defaultHeaders(),
      body: jsonEncode(_toJson(content)),
    );
    _ensureSuccess(response);
    return fromJson(jsonDecode(response.body));
  }

  Future<T> deleteAsync<T>(
    String relativeUrl,
    T Function(dynamic) fromJson,
  ) async {
    final uri = Uri.parse('$_baseUrl$relativeUrl');
    final response = await _httpClient.delete(
      uri,
      headers: await _defaultHeaders(),
    );
    _ensureSuccess(response);
    return fromJson(jsonDecode(response.body));
  }

  // ---------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------

  String _getBaseUrl() {
  
    if (_baseUrl.isEmpty) {
      throw StateError('BaseAddress is not configured.');
    }
    return _baseUrl;
  }

  Future<Map<String, String>> _defaultHeaders() async {
    final token = await _preferenceBroker.getTokenAsync() ?? _bearerToken;
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  void _ensureSuccess(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiBrokerException(
        'Request failed with status: ${response.statusCode}. '
        'Body: ${response.body}',
      );
    }
  }

  Map<String, dynamic> _toJson(dynamic content) {
    if (content is Map<String, dynamic>) return content;
    if (content == null) return {};
    return (content as dynamic).toJson() as Map<String, dynamic>;
  }
}

class ApiBrokerException implements Exception {
  final String message;
  const ApiBrokerException(this.message);

  @override
  String toString() => 'ApiBrokerException: $message';
}