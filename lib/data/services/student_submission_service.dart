import 'package:get_storage/get_storage.dart';
import 'package:mobile/data/controllers/session_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/data/models/student_submission_model.dart';
import 'dart:convert';

class StudentSubmissionService {
  final String _baseUrl = 'https://e-learn.godesqsites.com/api';
  final SessionController sessionController = Get.put(SessionController());
  final GetStorage storage = GetStorage();

  Future<StudentSubmission?> getStudentSubmission(int schoolWorkId) async {
    try {
      final token = sessionController.token.value;
      final userId = sessionController.user['id'];

      final response = await http.get(
        Uri.parse(
            '$_baseUrl/student-school-works/$schoolWorkId/submissions/students/$userId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return StudentSubmission.fromJson(jsonResponse['student_submission']);
      } else {
        throw Exception('Failed to load school works');
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Error", "Failed to load submissions");
      return null;
    }
  }
}
