class Instructor {
  final int id;
  final String email;
  final String username;
  final String firstname;
  final String lastname;
  final String? middlename;
  final int? age;
  final int instituteId;
  final int courseId;
  final String role;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  Instructor({
    required this.id,
    required this.email,
    required this.username,
    required this.firstname,
    required this.lastname,
    this.middlename,
    this.age,
    required this.instituteId,
    required this.courseId,
    required this.role,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) {
    return Instructor(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      middlename: json['middlename'],
      age: json['age'],
      instituteId: json['institute_id'],
      courseId: json['course_id'],
      role: json['role'],
      isVerified: json['is_verified'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
