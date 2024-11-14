import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:mobile/data/models/student_register_model.dart';

class StudentRegisterService {
  final String _baseUrl = 'https://e-learn.godesqsites.com/api';
  final GetStorage storage = GetStorage();

  Future<dynamic> register(StudentRegister studentRegister) async {
    // return print(studentRegister.toJson());
    final response = await http.post(
      Uri.parse('$_baseUrl/student/register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: json.encode(studentRegister.toJson()),
    );

    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to register');
    }
  }
}
