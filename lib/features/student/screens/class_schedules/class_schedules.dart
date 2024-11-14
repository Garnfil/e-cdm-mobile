import 'package:flutter/material.dart';
import 'package:mobile/data/models/class_schedule.dart';
import 'package:mobile/data/services/class_schedule_service.dart';
import 'package:mobile/features/student/models/task_model.dart';
import 'package:intl/intl.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/formatters/formatter.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _myCalendarPageState createState() => _myCalendarPageState();
}

class _myCalendarPageState extends State<CalendarPage> {
  List<ClassSchedule> schedules = [];
  bool isLoading = false;
  ClassScheduleService classScheduleService = ClassScheduleService();

  DateTime selectedDate = DateTime.now();
  late int selectedDayIndex;

  @override
  void initState() {
    super.initState();
    // Initialize the selectedDayIndex to the current day of the week
    selectedDayIndex =
        DateTime.now().weekday % 7; // Sunday as 0, Monday as 1, etc.
    fetchStudentClassSchedules();
  }

  List<Map<String, dynamic>> generateWeekDays(DateTime startDate) {
    List<Map<String, dynamic>> weekDays = [];
    DateTime weekStart =
        startDate.subtract(Duration(days: startDate.weekday % 7));

    for (int i = 0; i < 7; i++) {
      DateTime currentDay = weekStart.add(Duration(days: i));
      weekDays.add({
        "day": DateFormat('E').format(currentDay).substring(0, 1),
        "date": currentDay.day,
        "isActive": i == selectedDayIndex,
      });
    }
    return weekDays;
  }

  Future<void> fetchStudentClassSchedules() async {
    setState(() {
      isLoading = true;
    });

    schedules = await classScheduleService.getStudentClassSchedules();

    setState(() {
      isLoading = false;
    });
  }

  String formatTime(String timeString, String format) {
    DateTime dateTime = DateFormat("HH:mm:ss").parse(timeString);
    return DateFormat(format).format(dateTime);
  }

  Widget myCalendar(String day, int date, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDayIndex =
              date; // Update the selectedDayIndex when a day is tapped
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isActive ? TColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              day,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              date.toString(),
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Map<String, dynamic>> weekDays = generateWeekDays(selectedDate);

    return Stack(
      children: [
        Positioned(
          top: 40,
          child: Container(
            height: size.height - 160,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: weekDays.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> day = entry.value;
                      return myCalendar(
                          day["day"], day["date"], day["isActive"]);
                    }).toList(),
                  ),
                ),
                schedules.isEmpty
                    ? const Center(child: Text('No Schedule Found'))
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              schedules.length,
                              (index) {
                                final schedule = schedules[index];
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 25),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 20,
                                            height: 13,
                                            decoration: const BoxDecoration(
                                              color: TColors.secondaryColor,
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                right: Radius.circular(15),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          SizedBox(
                                            width: size.width / 1.15,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    text: schedule.startTime,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: formatTime(
                                                            schedule.startTime
                                                                .toString(),
                                                            'a'),
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: Colors.grey,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    text: schedule.endTime,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: formatTime(
                                                            schedule.startTime
                                                                .toString(),
                                                            'a'),
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: Colors.grey,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        height: 200,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        margin: const EdgeInsets.only(
                                          right: 10,
                                          left: 30,
                                        ),
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              schedule.classDetails.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              schedule.classDetails
                                                  .currentAssessmentCategory,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // CircleAvatar(
                                                //   radius: 12,
                                                //   backgroundImage:
                                                //       NetworkImage(task.profileImage),
                                                // ),
                                                const SizedBox(width: 8),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${schedule.instructor.firstname} ${schedule.instructor.lastname}",
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      schedule.instructor.email,
                                                      style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
