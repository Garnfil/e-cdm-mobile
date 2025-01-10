import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/controllers/session_controller.dart';
import 'package:mobile/navigation_menu.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

class StudentInfoRegistration extends StatefulWidget {
  const StudentInfoRegistration({super.key});

  @override
  State<StudentInfoRegistration> createState() =>
      _StudentInfoRegistrationState();
}

class _StudentInfoRegistrationState extends State<StudentInfoRegistration> {
  final sessionController = Get.put(SessionController());
  int _currentStep = 0;
  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'year_level': '',
    'section_id': '',
    'birthdate': '',
    'guardian_firstname': '',
    'guardian_lastname': '',
    'guardian_email': '',
    'guardian_contactno': ''
  };

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactnoController = TextEditingController();

  List<dynamic> sections = [];

  void _onStepContinue() async {
    if (_currentStep < 1) {
      setState(() {
        _currentStep += 1;
      });
    } else {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setState(() {
          _isLoading = true;
        });

        // Pass context explicitly to submitFormData
        await submitFormData();

        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> submitFormData() async {
    try {
      print("Token: ${sessionController.token.value}");
      final response = await http.post(
        Uri.parse('https://my-cdm.godesqsites.com/api/student/info-register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': "Bearer ${sessionController.token.value}",
        },
        body: json.encode(_formData),
      );

      if (response.statusCode == 200) {
        sessionController.updateUser('is_first_login', 0);

        Get.snackbar(
          'Success',
          'Form Submitted Successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to the NavigationMenu
        Get.offAll(() => const NavigationMenu());
      } else {
        final responseData = json.decode(response.body);
        throw Exception(responseData['message'] ?? "Failed to Submit");
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  void _onStepTapped(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  Future<void> fetchSections() async {
    final response = await http.get(
      Uri.parse(
          'https://my-cdm.godesqsites.com/api/sections?year_level=${_formData['year_level']}&course_id=${sessionController.user['course_id'] ?? 1}'),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        final jsonResponse = json.decode(response.body);
        sections = jsonResponse['sections'];
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Default date
      firstDate: DateTime(2000), // Minimum date
      lastDate: DateTime(2100), // Maximum date
    );

    if (pickedDate != null) {
      setState(() {
        _formData['birthdate'] =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
        _dateController.text = _formData['birthdate']!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: const Text('Student Information'),
              automaticallyImplyLeading: false, // Removes the back button
              toolbarHeight: TSizes.appBarHeight,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton.icon(
                    onPressed: () {
                      // Add your logout functionality here
                    },
                    icon: const Icon(Icons.logout,
                        color: Colors.white), // Black icon color
                    label: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white), // white text color
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: TColors.primaryColor, // Green background
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Colors.black,
                            width: 1.5), // Black border with width
                        borderRadius: BorderRadius.circular(
                            5), // Optional: Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8), // Extra padding inside the button
                    ),
                  ),
                ),
              ],
            ),
            body: Form(
              key: _formKey,
              child: Stepper(
                elevation: 0,
                type: StepperType.horizontal,
                currentStep: _currentStep,
                onStepContinue: _onStepContinue,
                onStepCancel: _onStepCancel,
                onStepTapped: _onStepTapped,
                steps: [
                  Step(
                    title: const Text('Student Info'),
                    content: Column(
                      children: [
                        const Text(
                          'Student Information',
                          style: TextStyle(
                            fontSize: TSizes.fontSizeXl,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Select Year Level',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.5), // Brutalist black border
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.5),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: TColors.black, width: 2)),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: '1',
                              child: Text('1st Year'),
                            ),
                            DropdownMenuItem(
                              value: '2',
                              child: Text('2nd Year'),
                            ),
                            DropdownMenuItem(
                              value: '3',
                              child: Text('3rd Year'),
                            ),
                            DropdownMenuItem(
                              value: '4',
                              child: Text('4th Year'),
                            ),
                          ],
                          onChanged: (value) {
                            _formData['year_level'] = value;
                            fetchSections();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a year level';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        DropdownButtonFormField<int>(
                          decoration: const InputDecoration(
                            labelText: 'Select Section',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.5), // Brutalist black border
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.5),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: TColors.black, width: 2)),
                          ),
                          items: sections.map<DropdownMenuItem<int>>((section) {
                            return DropdownMenuItem<int>(
                              value: section['id'],
                              child: Text(section['name']),
                            );
                          }).toList(),
                          onChanged: (value) {
                            _formData['section_id'] = value;
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a section';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _dateController,
                          readOnly: true, // Makes the field non-editable
                          decoration: InputDecoration(
                            labelText: 'Select Birthdate',
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.5), // Brutalist black border
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.5),
                            ),
                            border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: TColors.black, width: 2)),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () =>
                                  _selectDate(context), // Show date picker
                            ),
                          ),
                          onChanged: (value) {
                            _formData['birthdate'] = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a birthdate';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep > 0
                        ? StepState.complete
                        : StepState.editing,
                  ),
                  Step(
                    title: const Text('Guardian Registration'),
                    content: Column(
                      children: [
                        const Text(
                          'Guardian Registration',
                          style: TextStyle(
                            fontSize: TSizes.fontSizeXl,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _firstnameController,
                                onChanged: (value) {
                                  _formData['guardian_firstname'] = value;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please input a firstname';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1.5), // Brutalist black border
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.5),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1.5,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: TColors.black, width: 2)),
                                  labelText: "First Name",
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                controller: _lastnameController,
                                onChanged: (value) {
                                  _formData['guardian_lastname'] = value;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please input a lastname';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1.5), // Brutalist black border
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.5),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1.5,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: TColors.black, width: 2)),
                                  labelText: "Last Name",
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _emailController,
                          onChanged: (value) {
                            _formData['guardian_email'] = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please input a email';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.5), // Brutalist black border
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1.5,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: TColors.black, width: 2)),
                            labelText: "Email",
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _contactnoController,
                          onChanged: (value) {
                            _formData['guardian_contactno'] = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please input a contact no';
                            } else if (value.length != 10) {
                              return 'Contact Number contains only 10 numbers.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.5), // Brutalist black border
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1.5,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: TColors.black, width: 2)),
                            labelText: "Contact Number",
                            prefix: Text("+63"),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                    isActive: _currentStep >= 2,
                    state: StepState.editing,
                  ),
                ],
                controlsBuilder: (context, details) {
                  return Row(
                    children: [
                      if (_currentStep > 0)
                        TextButton.icon(
                          onPressed: details.onStepCancel,
                          label: const Text(
                            'Back',
                            style: TextStyle(
                                color:
                                    TColors.primaryColor), // white text color
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: TColors.white, // Green background
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.black,
                                  width: 1.5), // Black border with width
                              borderRadius: BorderRadius.circular(
                                  5), // Optional: Rounded corners
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8), // Extra padding inside the button
                          ),
                        ),
                      const SizedBox(width: 8),
                      TextButton.icon(
                        onPressed: details.onStepContinue,
                        label: Text(
                          _currentStep == 1 ? "Submit" : 'Next',
                          style: const TextStyle(
                              color: Colors.white), // white text color
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor:
                              TColors.primaryColor, // Green background
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.black,
                                width: 1.5), // Black border with width
                            borderRadius: BorderRadius.circular(
                                5), // Optional: Rounded corners
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8), // Extra padding inside the button
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
  }
}
