class SchoolWork {
  final int id;
  final int instructorId;
  final String title;
  final String description;
  final String type;
  final String status;
  final DateTime dueDatetime;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Assignment? assignment;
  final Activity? activity;
  final Exam? exam;
  final List<SchoolWorkAttachment>? attachments;

  SchoolWork({
    required this.id,
    required this.instructorId,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.dueDatetime,
    required this.createdAt,
    required this.updatedAt,
    this.assignment,
    this.activity,
    this.exam,
    this.attachments,
  });

  factory SchoolWork.fromJson(Map<String, dynamic> json) {
    return SchoolWork(
      id: json['id'],
      instructorId: json['instructor_id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      status: json['status'],
      dueDatetime: DateTime.parse(json['due_datetime']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      assignment: json['assignment'] != null
          ? Assignment.fromJson(json['assignment'])
          : null,
      activity:
          json['activity'] != null ? Activity.fromJson(json['activity']) : null,
      exam: json['exam'] != null ? Exam.fromJson(json['exam']) : null,
      attachments: json['attachments'] != null
          ? (json['attachments'] as List)
              .map((item) => SchoolWorkAttachment.fromJson(item))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'instructor_id': instructorId,
      'title': title,
      'description': description,
      'type': type,
      'status': status,
      'due_datetime': dueDatetime.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'assignment': assignment?.toJson(),
      'activity': activity?.toJson(),
      'exam': exam?.toJson(),
      'attachments':
          attachments?.map((attachment) => attachment.toJson()).toList(),
    };
  }
}

class Assignment {
  final int id;
  final int schoolWorkId;
  final String? notes;
  final String points;
  final String assessmentType;
  final DateTime createdAt;
  final DateTime updatedAt;

  Assignment({
    required this.id,
    required this.schoolWorkId,
    this.notes,
    required this.points,
    required this.assessmentType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'],
      schoolWorkId: json['school_work_id'],
      notes: json['notes'],
      points: json['points'],
      assessmentType: json['assessment_type'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school_work_id': schoolWorkId,
      'notes': notes,
      'points': points,
      'assessment_type': assessmentType,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Activity {
  final int id;
  final int schoolWorkId;
  final String? notes;
  final String points;
  final String assessmentType;
  final String activityType;
  final DateTime createdAt;
  final DateTime updatedAt;

  Activity({
    required this.id,
    required this.schoolWorkId,
    this.notes,
    required this.points,
    required this.assessmentType,
    required this.activityType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      schoolWorkId: json['school_work_id'],
      notes: json['notes'],
      points: json['points'],
      assessmentType: json['assessment_type'],
      activityType: json['activity_type'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school_work_id': schoolWorkId,
      'notes': notes,
      'points': points,
      'assessment_type': assessmentType,
      'activity_type': activityType,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Exam {
  final int id;
  final int schoolWorkId;
  final String? notes;
  final String points;
  final String assessmentType;
  final String examType;
  final DateTime createdAt;
  final DateTime updatedAt;

  Exam({
    required this.id,
    required this.schoolWorkId,
    this.notes,
    required this.points,
    required this.assessmentType,
    required this.examType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['id'],
      schoolWorkId: json['school_work_id'],
      notes: json['notes'],
      points: json['points'],
      assessmentType: json['assessment_type'],
      examType: json['exam_type'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school_work_id': schoolWorkId,
      'notes': notes,
      'points': points,
      'assessment_type': assessmentType,
      'exam_type': examType,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class SchoolWorkAttachment {
  final int id;
  final int schoolWorkId;
  final String attachmentName;
  final String schoolWorkType;
  final String attachmentType;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  SchoolWorkAttachment({
    required this.id,
    required this.schoolWorkId,
    required this.attachmentName,
    required this.schoolWorkType,
    required this.attachmentType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SchoolWorkAttachment.fromJson(Map<String, dynamic> json) {
    return SchoolWorkAttachment(
      id: json['id'],
      schoolWorkId: json['school_work_id'],
      attachmentName: json['attachment_name'],
      schoolWorkType: json['school_work_type'],
      attachmentType: json['attachment_type'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school_work_id': schoolWorkId,
      'attachment_name': attachmentName,
      'school_work_type': schoolWorkType,
      'attachment_type': attachmentType,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
