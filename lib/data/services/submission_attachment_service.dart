import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:mobile/data/controllers/session_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SubmissionAttachmentService {
  final String _baseUrl = 'https://my-cdm.godesqsites.com/api';
  final SessionController sessionController = Get.put(SessionController());
  final GetStorage storage = GetStorage();

  Future<void> submitAttachments(
      int schoolWorkId, List<Map<String, dynamic>> attachments) async {
    try {
      final user_id = sessionController.user['id'];
      final token = sessionController.token.value;
      var request = http.MultipartRequest(
          'POST', Uri.parse('$_baseUrl/student-school-works/submissions'));

      // Add headers
      request.headers.addAll({
        'Authorization': 'Bearer $token', // Replace with actual token if needed
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
      });

      request.fields['school_work_id'] = schoolWorkId.toString();
      request.fields['student_id'] = user_id.toString();

      for (int i = 0; i < attachments.length; i++) {
        var attachment = attachments[i];
        if (attachment['attachment_type'] == 'file' &&
            attachment['attachment'] != null) {
          request.files.add(await http.MultipartFile.fromPath(
            'attachments[$i][attachment]',
            attachment['attachment'].path,
            filename: attachment['attachment'].name,
          ));
        } else if (attachment['attachment_type'] == 'link') {
          request.fields['attachments[$i][attachment]'] =
              attachment['attachment'];
        }
        request.fields['attachments[$i][attachment_type]'] =
            attachment['attachment_type'];
      }

      var response = await request.send();

      // To get the response body
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print('Response Body: $responseBody');
        Get.snackbar('Success', 'Upload Successfully');
      } else {
        final errorBody = await response.stream.bytesToString();
        print('Failed to upload. Status code: ${response.statusCode}');
        print('Error Body: $errorBody');

        // Decode the error body
        var error = jsonDecode(errorBody);

        // Print the entire error map for debugging
        print('Error Map: $error');

        // Check if 'message' exists in the error map before accessing it
        if (error.containsKey('message')) {
          throw Exception(
              error['message']); // Use the 'message' field if it exists
        } else {
          throw Exception(
              'An unknown error occurred.'); // Fallback error message
        }
      }
    } catch (e) {
      String errorMessage;

      // Check if the caught exception is of type Exception
      if (e is Exception) {
        // If it's a string, use it directly
        errorMessage = e.toString();
      } else if (e is Map) {
        // If it's a Map, check if it has a 'message' field
        if (e.containsKey('message')) {
          errorMessage = e['message'];
        } else {
          errorMessage = 'An unknown error occurred.';
        }
      } else {
        // Fallback for unexpected exception types
        errorMessage = 'An unexpected error occurred: ${e.toString()}';
      }

      print(errorMessage); // Log the error message
      Get.snackbar(
          'Error', errorMessage); // Show the error message in a snackbar
    }
  }

  // Future<void> getSubmissionsAttachments
}
