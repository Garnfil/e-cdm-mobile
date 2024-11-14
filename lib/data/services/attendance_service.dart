import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/data/controllers/session_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AttendanceService {
  final String _baseUrl = 'https://e-learn.godesqsites.com/api';
  final SessionController sessionController = Get.put(SessionController());
  final GetStorage storage = GetStorage();

  Future<void> submitAttendance(attendanceId) async {
    final token = sessionController.token.value;
    final user_id = sessionController.user['id'];

    final response = await http.post(
      Uri.parse('$_baseUrl/attendances/students/submit'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json', // Add this line
        'Authorization': 'Bearer $token'
      },
      body: json.encode({
        "attendance_id": attendanceId,
        "student_id": user_id,
      }),
    );

    print(response.body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      Get.snackbar('Success', 'Attendance Submitted Successfully');
    } else {
      Get.snackbar('Failed', 'Attendance Failed To Submit');
    }
  }
}
