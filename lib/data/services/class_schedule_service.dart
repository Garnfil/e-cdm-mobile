import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/data/controllers/session_controller.dart';
import 'dart:convert';

import 'package:mobile/data/models/class_schedule.dart';

class ClassScheduleService {
  final String _baseUrl = 'https://e-learn.godesqsites.com/api';
  final SessionController sessionController = Get.put(SessionController());
  final GetStorage storage = GetStorage();

  Future<List<ClassSchedule>> getStudentClassSchedules() async {
    try {
      final token = sessionController.token.value;
      final user_id = sessionController.user['id'];

      final response = await http.get(
        Uri.parse('$_baseUrl/students/$user_id/class-schedules'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      print("Response Class Schedules: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Iterable classList = jsonResponse['schedules'];
        return classList
            .map((classItem) => ClassSchedule.fromJson(classItem))
            .toList();
      } else {
        throw Exception('No Class Schedule Found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error Getting Schedules');
      return [];
    }
  }
}
