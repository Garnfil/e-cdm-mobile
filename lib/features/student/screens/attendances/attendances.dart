import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/controllers/session_controller.dart';
import 'package:mobile/data/models/attendance_model.dart';
import 'package:mobile/data/services/attendance_service.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'dart:async';
import 'package:intl/intl.dart'; // Add intl package for date formatting
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClassAttedanceScreen extends StatefulWidget {
  final int classId;
  const ClassAttedanceScreen({super.key, required this.classId});

  @override
  State<ClassAttedanceScreen> createState() => _ClassAttedanceScreenState();
}

class _ClassAttedanceScreenState extends State<ClassAttedanceScreen> {
  Attendance? attendance;
  bool isLoading = true;
  final AttendanceService attendanceService = AttendanceService();

  late String currentTime;
  late Timer timer;
  late String dayOfWeek = '';
  late String todayDate = '';

  @override
  void initState() {
    super.initState();
    // Initialize the current time
    currentTime = _formatTime(DateTime.now());

    // Initialize dayOfWeek and todayDate
    dayOfWeek = DateFormat('EEEE').format(DateTime.now());
    todayDate = DateFormat('MMMM d, yyyy').format(DateTime.now());

    // Update the time every second
    timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());

    fetchAttendance();
  }

  void fetchAttendance() async {
    final SessionController sessionController = Get.put(SessionController());

    final token = sessionController.token.value;

    final url = Uri.parse(
        'https://my-cdm.godesqsites.com/api/attendances/classes/${widget.classId}/today');
    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          attendance = data['attendance'] != null
              ? Attendance.fromJson(data['attendance'])
              : null;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to format the time as needed
  String _formatTime(DateTime dateTime) {
    // Format to 12-hour with AM/PM
    String hour = (dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12)
        .toString()
        .padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String period = dateTime.hour >= 12 ? 'PM' : 'AM';

    return "$hour:$minute $period";
  }

  void _updateTime() {
    setState(() {
      currentTime = _formatTime(DateTime.now());
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Attendance")),
      backgroundColor: TColors.primaryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                /// Class Attendance Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff0B4D10), Color(0xffFFC900)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(color: TColors.black, width: 2),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PRELIM',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        '4H - IT CAPSTONE PROCJECT',
                        style: TextStyle(
                          fontSize: TSizes.fontSizeXl,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 45,
                ),

                Center(
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : attendance != null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "There's an attendance here",
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  currentTime,
                                  style: const TextStyle(
                                      fontSize: 45,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "$dayOfWeek $todayDate",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () async {
                                    await attendanceService
                                        .submitAttendance(attendance!.id);

                                    fetchAttendance();
                                  },
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xff054721),
                                          Color(0xff35D077)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                        style: BorderStyle.solid,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              TImages.handCursorImage),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Present',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const Text(
                              "No attendance today.",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                ),

                ///
              ],
            ),
          ),
        ),
      ),
    );
  }
}
