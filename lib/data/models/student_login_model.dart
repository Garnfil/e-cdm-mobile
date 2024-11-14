class StudentLogin {
  String student_id;
  String email;
  String password;

  StudentLogin(
      {required this.student_id, required this.email, required this.password});

  factory StudentLogin.fromJson(Map<String, dynamic> json) => StudentLogin(
        student_id: json['student_id'],
        email: json['email'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {
        "student_id": student_id,
        "email": email,
        "password": password,
      };
}
