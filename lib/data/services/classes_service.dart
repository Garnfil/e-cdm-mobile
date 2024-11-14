import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/data/controllers/session_controller.dart';
import 'dart:convert';
import 'package:mobile/data/models/class_model.dart';

class ClassService {
  final String _baseUrl = 'https://e-learn.godesqsites.com/api';
  final SessionController sessionController = Get.put(SessionController());
  final GetStorage storage = GetStorage();

  Future<ClassRoom?> getClassDetails(classId) async {
    try {
      final token = sessionController.token.value;
      final response = await http.get(
        Uri.parse('$_baseUrl/classes/$classId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      print("Class Details: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return ClassRoom.fromJson(jsonResponse['class']);
      } else {
        throw Exception('Failed to load school works');
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<ClassRoom>> getStudentClasses() async {
    try {
      final user_id = sessionController.user['id'];
      final token = sessionController.token.value;
      final response = await http.get(
        Uri.parse('$_baseUrl/classes/students/$user_id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Check if the response status is 'success' and then parse the 'classes' list
        if (jsonResponse['status'] == 'success') {
          Iterable classList = jsonResponse['classes'];
          return classList
              .map((classItem) => ClassRoom.fromJson(classItem))
              .toList();
        } else {
          throw Exception('Failed to load classes');
        }
      } else {
        throw Exception('Failed to load classes');
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load classes");
      return []; // Return an empty list in case of an error
    }
  }

  Future<void> joinClass(String classCode) async {
    final user_id = sessionController.user['id'];
    final token = sessionController.token.value;
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/classes/join'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode({'class_code': classCode, 'student_id': user_id}),
      );

      print(response.body);

      if (response.statusCode != 200) {
        throw Exception('Failed to join');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to join class');
    }
  }
}
