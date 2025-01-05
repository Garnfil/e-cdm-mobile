import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobile/data/controllers/session_controller.dart';
import 'package:mobile/features/student/controllers/classes/class_controller.dart';
import 'package:mobile/utils/constants/colors.dart';

class AvailableClassesScreen extends StatefulWidget {
  @override
  _AvailableClassesScreenState createState() => _AvailableClassesScreenState();
}

class _AvailableClassesScreenState extends State<AvailableClassesScreen> {
  final SessionController sessionController = Get.put(SessionController());
  final ClassController classController = Get.put(ClassController());
  List<Map<String, dynamic>> _availableClasses = [];

  @override
  void initState() {
    super.initState();
    _fetchAvailableClasses();
  }

  Future<void> _fetchAvailableClasses() async {
    try {
      // Replace with your API endpoint
      final response = await http.get(
          Uri.parse(
              'https://e-learn.godesqsites.com/api/classes/student-available-classes'),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer ${sessionController.token.value}"
          });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        setState(() {
          _availableClasses =
              List<Map<String, dynamic>>.from(responseData['classes']);
        });
      } else {
        throw Exception('Failed to load classes');
      }
    } catch (e) {
      Get.snackbar(
        'Failed', // Title
        e.toString(), // Message
        snackPosition: SnackPosition.TOP, // Position: TOP or BOTTOM
        backgroundColor: TColors.error, // Background color
        colorText: TColors.white, // Text color
        borderRadius: 8.0, // Border radius
        duration: const Duration(seconds: 4), // Duration to display
        isDismissible: true, // Allow dismissal
      );
    }
  }

  Future<void> _joinClass(int classId, String classCode) async {
    try {
      // Replace with your API endpoint
      final response = await http.post(
        Uri.parse('https://e-learn.godesqsites.com/api/classes/join'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${sessionController.token.value}"
        },
        body: json.encode({
          'class_code': classCode,
          'student_id': sessionController.user['id']
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _availableClasses
              .removeWhere((classItem) => classItem['id'] == classId);
        });
        Get.snackbar(
          'Success', // Title
          "You are successfully joined in that class.", // Message
          snackPosition: SnackPosition.TOP, // Position: TOP or BOTTOM
          backgroundColor: TColors.success, // Background color
          colorText: TColors.white, // Text color
          borderRadius: 8.0, // Border radius
          duration: const Duration(seconds: 4), // Duration to display
          isDismissible: true, // Allow dismissal
        );
        classController.fetchStudentClasses();
      } else {
        throw Exception('Failed to join class');
      }
    } catch (e) {
      Get.snackbar(
        'Failed', // Title
        e.toString(), // Message
        snackPosition: SnackPosition.TOP, // Position: TOP or BOTTOM
        backgroundColor: TColors.error, // Background color
        colorText: TColors.white, // Text color
        borderRadius: 8.0, // Border radius
        duration: const Duration(seconds: 4), // Duration to display
        isDismissible: true, // Allow dismissal
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.primaryBackground,
      appBar: AppBar(
        title: const Text('Available Classes'),
        backgroundColor: const Color(0xFF0B4C11),
        foregroundColor: Colors.white,
      ),
      body: _availableClasses.isEmpty
          ? const Center(child: Text('No Available Classes'))
          : Padding(
              padding: const EdgeInsets.all(15),
              child: _availableClasses.isEmpty
                  ? const Center(
                      child: Text(
                        'No classes available',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _availableClasses.length,
                      itemBuilder: (context, index) {
                        final classItem = _availableClasses[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black, offset: Offset(4, 4)),
                                BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-2, -2)),
                              ],
                            ),
                            child: ListTile(
                              title: Text(
                                classItem['title'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Instructor: ${classItem['instructor']['firstname']} ${classItem['instructor']['lastname']}',
                              ),
                              trailing: ElevatedButton(
                                onPressed: () => _joinClass(
                                    classItem['id'], classItem['class_code']),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: TColors.buttonPrimary,
                                  foregroundColor: TColors.white,
                                  shape: const RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.black, // Border color
                                      width: 2, // Border thickness
                                    ),
                                    borderRadius: BorderRadius
                                        .zero, // Remove rounded edges
                                  ),
                                ),
                                child: const Text(
                                  'Join',
                                  style: TextStyle(color: TColors.white),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}
