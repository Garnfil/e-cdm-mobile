class StudentLogin {
  String studentId;
  String email;
  String password;

  StudentLogin(
      {required this.studentId, required this.email, required this.password});

  factory StudentLogin.fromJson(Map<String, dynamic> json) => StudentLogin(
        studentId: json['studentId'],
        email: json['email'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "email": email,
        "password": password,
      };
}
