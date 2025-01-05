import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:mobile/data/models/student_login_model.dart';

class StudentLoginService {
  final String _baseUrl = 'https://e-learn.godesqsites.com/api';
  final GetStorage storage = GetStorage();

  Future<dynamic> login(StudentLogin studentLogin) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/student/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: json.encode(studentLogin.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);

      // Save token and user data to storage
      storage.write('token', data['token']);
      storage.write('user', data['user']);

      return data;
    } else {
      final responseData = json.decode(response.body);
      throw Exception("${responseData['message'] ?? "Failed to Login!"}");
    }
  }
}
