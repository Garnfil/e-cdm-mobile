import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/student_login_model.dart';

class StudentLoginService {
  Future<dynamic> login(StudentLogin studentLogin) async {
    const String _baseUrl = 'http://192.168.56.1:8000/api';

    final response = await http.post(
      Uri.parse('$_baseUrl/student/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(studentLogin.toJson()),
    );

    if (response.statusCode != 201 || response.statusCode != 200) {
      throw Exception('Failed to login');
    }

    return json.decode(response.body);
  }
}
