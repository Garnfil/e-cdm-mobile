class ClassRoom {
  int id;
  String classCode;
  String title;
  String currentAssessmentCategory;
  String semester;
  int subjectId;
  int sectionId;
  int instructorId;
  String? description;
  String? coverImageFileName;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  ClassRoom({
    required this.id,
    required this.classCode,
    required this.title,
    required this.currentAssessmentCategory,
    required this.semester,
    required this.subjectId,
    required this.sectionId,
    required this.instructorId,
    this.description,
    this.coverImageFileName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  // From JSON
  factory ClassRoom.fromJson(Map<String, dynamic> json) {
    return ClassRoom(
      id: json['id'],
      classCode: json['class_code'],
      title: json['title'],
      currentAssessmentCategory: json['current_assessment_category'],
      semester: json['semester'],
      subjectId: json['subject_id'],
      sectionId: json['section_id'],
      instructorId: json['instructor_id'],
      description: json['description'],
      coverImageFileName: json['cover_image_file_name'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'class_code': classCode,
      'title': title,
      'current_assessment_category': currentAssessmentCategory,
      'semester': semester,
      'subject_id': subjectId,
      'section_id': sectionId,
      'instructor_id': instructorId,
      'description': description,
      'cover_image_file_name': coverImageFileName,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
