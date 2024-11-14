class Attendance {
  final int id;
  final int classId;
  final String attendanceCode;
  final int? studentId;
  final DateTime attendanceDatetime;
  final int gracePeriodMinute;
  final DateTime createdAt;
  final DateTime updatedAt;

  Attendance({
    required this.id,
    required this.classId,
    required this.attendanceCode,
    this.studentId,
    required this.attendanceDatetime,
    required this.gracePeriodMinute,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'] as int,
      classId: json['class_id'] as int,
      attendanceCode: json['attendance_code'] as String,
      studentId: json['student_id'] as int?,
      attendanceDatetime: DateTime.parse(json['attendance_datetime'] as String),
      gracePeriodMinute: json['grace_period_minute'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
