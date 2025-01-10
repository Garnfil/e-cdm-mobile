import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';

import 'package:mobile/data/controllers/session_controller.dart';
import 'package:mobile/features/student/screens/profile/settings.dart';
import 'package:mobile/utils/constants/colors.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _emailController;
  late TextEditingController _firstnameController;
  late TextEditingController _lastnameController;
  late TextEditingController _yearLevelController;
  late TextEditingController _sectionController;
  late TextEditingController _birthdateController;
  late TextEditingController _ageController;

  final _formKey = GlobalKey<FormState>();

  bool isLoading = true;
  Map<String, dynamic> userProfile = {};

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _firstnameController = TextEditingController();
    _lastnameController = TextEditingController();
    _yearLevelController = TextEditingController();
    _sectionController = TextEditingController();
    _birthdateController = TextEditingController();
    _ageController = TextEditingController();

    // Fetch the user data when the screen is loaded
    fetchUserProfile();
  }

  // Fetch user profile data from the API
  Future<void> fetchUserProfile() async {
    final sessionController = Get.put(SessionController());
    final id = sessionController.user['id'];
    final response = await http.get(
      Uri.parse('https://my-cdm.godesqsites.com/api/student/profile/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "Bearer ${sessionController.token.value}",
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userProfile =
            Map<String, dynamic>.from(json.decode(response.body)['user']);
        _emailController.text = userProfile['email'] ?? '';
        _firstnameController.text = userProfile['firstname'] ?? '';
        _lastnameController.text = userProfile['lastname'] ?? '';
        _yearLevelController.text = userProfile['year_level'] ?? '';
        _sectionController.text = userProfile['section'] ?? '';
        _birthdateController.text = userProfile['birthdate'] ?? '';
        _ageController.text = userProfile['age'].toString();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('Failed to fetch data');
    }
  }

  // Save updated profile data
  Future<void> saveProfile() async {
    final sessionController = Get.put(SessionController());
    final id = sessionController.user['id'];

    final response = await http.put(
      Uri.parse('https://my-cdm.godesqsites.com/api/student/profile/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "Bearer ${sessionController.token.value}",
      },
      body: json.encode({
        'firstname': _firstnameController.text,
        'lastname': _lastnameController.text,
        'email': _emailController.text,
        'year_level': _yearLevelController.text,
        'section': _sectionController.text,
        'age': _ageController.text,
        'birthdate': _birthdateController.text,
      }),
    );

    if (response.statusCode == 200) {
      print('Profile updated successfully');
    } else {
      print('Failed to update profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.green,
            ),
            onPressed: () {
              Get.to(SettingsPage());
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 350,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: Offset(5, 5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Center(
                        child: Text(
                          "EDIT PROFILE",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: TColors.primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Name Field
                      _buildTextField(
                        "First Name",
                        _firstnameController,
                        "Enter your first name",
                      ),
                      SizedBox(height: 15),

                      // Last Name Field
                      _buildTextField(
                        "Last Name",
                        _lastnameController,
                        "Enter your last name",
                      ),
                      SizedBox(height: 15),

                      // Email Field
                      _buildTextField(
                        "Email",
                        _emailController,
                        "Enter your email",
                      ),
                      SizedBox(height: 15),

                      // Address Field
                      _buildTextField(
                        "Year Level",
                        _yearLevelController,
                        "Enter your address",
                      ),
                      SizedBox(height: 15),

                      // Age Field
                      _buildTextField(
                        "Section",
                        _sectionController,
                        "Enter your age",
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 15),

                      // Gender Field
                      _buildTextField(
                        "Age",
                        _ageController,
                        "Enter your gender",
                      ),
                      SizedBox(height: 15),

                      // Birthdate Field
                      _buildTextField(
                        "Birthdate",
                        _birthdateController,
                        "YYYY-MM-DD",
                      ),
                      SizedBox(height: 25),

                      // Save Button
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: TColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 50,
                            ),
                          ),
                          onPressed: saveProfile,
                          child: Text(
                            "SAVE",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable TextField Widget
  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String hintText, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: TColors.primaryColor,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "$label cannot be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: TColors.primaryColor,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _yearLevelController.dispose();
    _sectionController.dispose();
    _birthdateController.dispose();
    _ageController.dispose();
    super.dispose();
  }
}
