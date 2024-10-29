class Studnt {
  final int id;
  final String studentId;
  final String email;
  final String firstname;
  final String? middlename;
  final String lastname;
  final String yearLevel;
  final String section;
  final int instituteId;
  final int courseId;
  final int age;
  final String birthdate;
  final String? gender;
  final String? currentAddress;
  final String? avatarPath;
  final String role;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Studnt({
    required this.id,
    required this.studentId,
    required this.email,
    required this.firstname,
    this.middlename,
    required this.lastname,
    required this.yearLevel,
    required this.section,
    required this.instituteId,
    required this.courseId,
    required this.age,
    required this.birthdate,
    this.gender,
    this.currentAddress,
    this.avatarPath,
    required this.role,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Studnt.fromJson(Map<String, dynamic> json) {
    return Studnt(
      id: json['id'],
      studentId: json['student_id'],
      email: json['email'],
      firstname: json['firstname'],
      middlename: json['middlename'],
      lastname: json['lastname'],
      yearLevel: json['year_level'],
      section: json['section'],
      instituteId: json['institute_id'],
      courseId: json['course_id'],
      age: json['age'],
      birthdate: json['birthdate'],
      gender: json['gender'],
      currentAddress: json['current_address'],
      avatarPath: json['avatar_path'],
      role: json['role'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'email': email,
      'firstname': firstname,
      'middlename': middlename,
      'lastname': lastname,
      'year_level': yearLevel,
      'section': section,
      'institute_id': instituteId,
      'course_id': courseId,
      'age': age,
      'birthdate': birthdate,
      'gender': gender,
      'current_address': currentAddress,
      'avatar_path': avatarPath,
      'role': role,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
