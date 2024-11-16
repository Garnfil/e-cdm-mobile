class StudentRegister {
  String student_id;
  String email;
  String firstname;
  String lastname;
  String password;
  int institute_id;
  int course_id;

  StudentRegister(
      {required this.student_id,
      required this.email,
      required this.password,
      required this.firstname,
      required this.lastname,
      required this.institute_id,
      required this.course_id});

  factory StudentRegister.fromJson(Map<String, dynamic> json) =>
      StudentRegister(
        student_id: json['student_id'],
        email: json['email'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        password: json['password'],
        institute_id: json['institute_id'],
        course_id: json['course_id'],
      );

  Map<String, dynamic> toJson() => {
        "student_id": student_id,
        "email": email,
        "password": password,
        "firstname": firstname,
        "lastname": lastname,
        "institute_id": institute_id,
        "course_id": course_id,
      };
}
