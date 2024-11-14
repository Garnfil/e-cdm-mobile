class StudentRegister {
  String student_id;
  String email;
  String firstname;
  String lastname;
  String password;

  StudentRegister(
      {required this.student_id,
      required this.email,
      required this.password,
      required this.firstname,
      required this.lastname});

  factory StudentRegister.fromJson(Map<String, dynamic> json) =>
      StudentRegister(
        student_id: json['student_id'],
        email: json['email'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {
        "student_id": student_id,
        "email": email,
        "password": password,
        "firstname": firstname,
        "lastname": lastname,
      };
}
