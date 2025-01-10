import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/data/controllers/session_controller.dart';
import 'package:mobile/data/models/school_work_model.dart';

class SchoolWorkService {
  final String _baseUrl = 'https://my-cdm.godesqsites.com/api';
  final SessionController sessionController = Get.put(SessionController());
  final GetStorage storage = GetStorage();

  Future<SchoolWork?> getSingleSchoolWork(int schoolWorkId) async {
    try {
      final token = sessionController.token.value;
      // Make an API call or database query to fetch a single school work
      final response = await http.get(
        Uri.parse('$_baseUrl/school-works/$schoolWorkId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      print(response);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return SchoolWork.fromJson(jsonResponse['school_work']);
      } else {
        throw Exception('Failed to load school works');
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to load school work");
      return null;
    }
  }

  Future<List<SchoolWork>> getStudentSchoolWorks(int classId) async {
    try {
      final token = sessionController.token.value;
      final response = await http.get(
        Uri.parse('$_baseUrl/classes/$classId/school-works'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Check if the response status is 'success' and then parse the 'school_works' list
        if (jsonResponse['status'] == 'success') {
          Iterable schoolWorks = jsonResponse['school_works'];
          return schoolWorks
              .map((classItem) => SchoolWork.fromJson(classItem))
              .toList();
        } else {
          throw Exception('Failed to load school works');
        }
      } else {
        throw Exception('Failed to load school works');
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to load school works");
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<SchoolWork>> getTodosSchoolWorks(int classId) async {
    try {
      final token = sessionController.token.value;
      final user_id = sessionController.user['id'];

      final response = await http.get(
        Uri.parse(
            '$_baseUrl/students/$user_id/classes/$classId/school-works/todos'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Check if the response status is 'success' and then parse the 'school_works' list
        if (jsonResponse['status'] == 'success') {
          Iterable schoolWorks = jsonResponse['school_works'];
          return schoolWorks
              .map((classItem) => SchoolWork.fromJson(classItem))
              .toList();
        } else {
          throw Exception('Failed to load school works');
        }
      } else {
        throw Exception('Failed to load school works');
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load school works");
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<SchoolWork>> getCompletedSchoolWorks(int classId) async {
    try {
      final token = sessionController.token.value;
      final user_id = sessionController.user['id'];

      final response = await http.get(
        Uri.parse(
            '$_baseUrl/students/$user_id/classes/$classId/school-works/completed'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Check if the response status is 'success' and then parse the 'school_works' list
        if (jsonResponse['status'] == 'success') {
          Iterable schoolWorks = jsonResponse['school_works'];
          return schoolWorks
              .map((classItem) => SchoolWork.fromJson(classItem))
              .toList();
        } else {
          throw Exception('Failed to load school works');
        }
      } else {
        throw Exception('Failed to load school works');
      }
    } catch (e) {
      print('School Work Error:');
      print(e);
      Get.snackbar("Error", "Failed to load school works");
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<SchoolWork>> getMissingSchoolWorks(int classId) async {
    try {
      final token = sessionController.token.value;
      final user_id = sessionController.user['id'];

      final response = await http.get(
        Uri.parse(
            '$_baseUrl/students/$user_id/classes/$classId/school-works/missing'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Check if the response status is 'success' and then parse the 'school_works' list
        if (jsonResponse['status'] == 'success') {
          Iterable schoolWorks = jsonResponse['school_works'];
          return schoolWorks
              .map((classItem) => SchoolWork.fromJson(classItem))
              .toList();
        } else {
          throw Exception('Failed to load school works');
        }
      } else {
        throw Exception('Failed to load school works');
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load school works");
      return []; // Return an empty list in case of an error
    }
  }
}

// Future<List<ClassRoom>> getStudentSchoolWorks() async {}
