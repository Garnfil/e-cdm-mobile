import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:mobile/data/controllers/session_controller.dart';
import 'package:mobile/data/models/student_register_model.dart';
import 'package:mobile/features/authentication/controllers/student_register/student_register_controller.dart';
import 'package:mobile/features/authentication/screens/login/login.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final StudentRegisterController studentRegisterController =
      StudentRegisterController();
  final SessionController sessionController = Get.put(SessionController());

  final studentIdController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  List<dynamic> institutes = [];
  List<dynamic> courses = [];
  int? selectedInstituteId;
  int? selectedCourseId;

  @override
  void initState() {
    super.initState();
    fetchInstitutes();
    fetchCourses();
  }

  Future<void> fetchInstitutes() async {
    final response = await http.get(
      Uri.parse('https://my-cdm.godesqsites.com/api/institutes'),
      headers: {
        'Accept': 'application/json',
      },
    );
    print("Institutes: ${response.body}");

    if (response.statusCode == 200) {
      setState(() {
        final jsonResponse = json.decode(response.body);
        institutes = jsonResponse['institutes'];
      });
    }
  }

  Future<void> fetchCourses() async {
    final response = await http.get(
      Uri.parse('https://my-cdm.godesqsites.com/api/courses'),
      headers: {
        'Accept': 'application/json',
      },
    );
    print("Courses: ${response.body}");

    if (response.statusCode == 200) {
      setState(() {
        final jsonResponse = json.decode(response.body);
        courses = jsonResponse['courses'];
      });
    }
  }

  void submitRegistration() {
    final studentData = StudentRegister(
      student_id: studentIdController.text,
      email: emailController.text,
      password: passwordController.text,
      firstname: firstnameController.text,
      lastname: lastnameController.text,
      institute_id: selectedInstituteId ?? 0,
      course_id: selectedCourseId ?? 0,
    );

    studentRegisterController.submitRegistration(studentData);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
          child: Column(
            children: [
              TextFormField(
                controller: studentIdController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: TColors.black, width: 2)),
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: "Student ID",
                ),
              ),
              const SizedBox(height: 20),

              // First Name and Last Name Row with Expanded Widgets
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: firstnameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: TColors.black, width: 2)),
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: "First Name",
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: lastnameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: TColors.black, width: 2)),
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: "Last Name",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Institute Dropdown
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: "Institute",
                  border: OutlineInputBorder(),
                ),
                value: selectedInstituteId,
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    selectedInstituteId = value;
                  });
                },
                items: institutes.map<DropdownMenuItem<int>>((institute) {
                  return DropdownMenuItem<int>(
                    value: institute['id'],
                    child: Text(institute['name']),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Course Dropdown
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: "Course",
                  border: OutlineInputBorder(),
                ),
                value: selectedCourseId,
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    selectedCourseId = value;
                  });
                },
                items: courses.map<DropdownMenuItem<int>>((course) {
                  return DropdownMenuItem<int>(
                    value: course['id'],
                    child: Text(course['name']),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: TColors.black, width: 2)),
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: "Email",
                ),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: TColors.black, width: 2)),
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: "Password",
                  suffixIcon: Icon(Iconsax.eye_slash),
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.buttonPrimary,
                    foregroundColor: TColors.white,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onPressed: () {
                    if (selectedInstituteId != null &&
                        selectedCourseId != null) {
                      submitRegistration();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Please select an institute and course.')),
                      );
                    }
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: TSizes.fontSizeMd),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: TColors.black,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onPressed: () => Get.to(const LoginScreen()),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        fontSize: TSizes.fontSizeMd,
                        color: TColors.textPrimary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
