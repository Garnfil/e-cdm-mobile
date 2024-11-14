import 'dart:convert';

import 'package:mobile/data/models/class_model.dart';
import 'package:mobile/data/models/instructor_model.dart';

class ClassSchedule {
  final int id;
  final int instructorId;
  final int classId;
  final DateTime? scheduleDate;
  final List<String> daysOfWeek;
  final String startTime;
  final String endTime;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Instructor instructor;
  final ClassRoom classDetails;

  ClassSchedule({
    required this.id,
    required this.instructorId,
    required this.classId,
    this.scheduleDate,
    required this.daysOfWeek,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    required this.instructor,
    required this.classDetails,
  });

  factory ClassSchedule.fromJson(Map<String, dynamic> json) {
    return ClassSchedule(
      id: json['id'],
      instructorId: json['instructor_id'],
      classId: json['class_id'],
      scheduleDate: json['schedule_date'] != null
          ? DateTime.parse(json['schedule_date'])
          : null,
      daysOfWeek: List<String>.from(jsonDecode(json['days_of_week'])),
      startTime: json['start_time'],
      endTime: json['end_time'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      instructor: Instructor.fromJson(json['instructor']),
      classDetails: ClassRoom.fromJson(json['class']),
    );
  }
}
