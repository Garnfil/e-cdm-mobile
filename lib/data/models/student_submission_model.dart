import 'package:mobile/data/models/student_model.dart';

class StudentSubmission {
  final int id;
  final int schoolWorkId;
  final int studentId;
  final String? score;
  final String? grade;
  final String schoolWorkType;
  final DateTime datetimeSubmitted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<StudentSubmissionAttachment>? attachments;
  final Student? student;

  StudentSubmission({
    required this.id,
    required this.schoolWorkId,
    required this.studentId,
    this.score,
    this.grade,
    required this.schoolWorkType,
    required this.datetimeSubmitted,
    required this.createdAt,
    required this.updatedAt,
    this.attachments,
    this.student,
  });

  factory StudentSubmission.fromJson(Map<String, dynamic> json) {
    return StudentSubmission(
      id: json['id'],
      schoolWorkId: json['school_work_id'],
      studentId: json['student_id'],
      score: json['score'],
      grade: json['grade'],
      schoolWorkType: json['school_work_type'],
      datetimeSubmitted: DateTime.parse(json['datetime_submitted']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      attachments: json['attachments'] != null
          ? (json['attachments'] as List)
              .map((item) => StudentSubmissionAttachment.fromJson(item))
              .toList()
          : null,
      student: json['student'] != null
          ? Student.fromJson(json['student'] as Map<String, dynamic>)
          : null,
    );
  }

  // factory StudentSubmission.fromJson(Map<String, dynamic> json) {
  //   return StudentSubmission(
  //     status: json['status'] as String,
  //     studentSubmissions: (json['student_submissions'] as List)
  //         .map((submissionJson) => StudentSubmission.fromJson(submissionJson))
  //         .toList(),
  //   );
  // }
}

class StudentSubmissionAttachment {
  final int id;
  final int studentSubmissionId;
  final int studentId;
  final String attachmentName;
  final String attachmentType;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  StudentSubmissionAttachment({
    required this.id,
    required this.studentSubmissionId,
    required this.studentId,
    required this.attachmentName,
    required this.attachmentType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudentSubmissionAttachment.fromJson(Map<String, dynamic> json) {
    return StudentSubmissionAttachment(
      id: json['id'] as int,
      studentSubmissionId: json['student_submission_id'] as int,
      studentId: json['student_id'] as int,
      attachmentName: json['attachment_name'] as String,
      attachmentType: json['attachment_type'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
