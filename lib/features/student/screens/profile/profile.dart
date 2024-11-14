import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/features/student/screens/profile/settings.dart';
import 'package:mobile/utils/constants/colors.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.green,
            ),
            onPressed: () {
              Get.to(SettingsPage());
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                              ))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: TColors.primaryColor,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Aligns children with space between
                children: [
                  Expanded(
                    child: buildTextField("First Name", "", false),
                  ),
                  const SizedBox(
                      width: 5), // Adds space between the text fields
                  Expanded(
                    child: buildTextField("Last Name", "", false),
                  ),
                  const SizedBox(
                      width: 5), // Adds space between the text fields
                  Expanded(
                    child: buildTextField("Middle Name", "", false),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Aligns children with space between
                children: [
                  Expanded(
                    child: buildTextField("Email Name", "", false),
                  ),
                  const SizedBox(
                      width: 5), // Adds space between the text fields
                  Expanded(
                    child: buildTextField("Student ID", "", false),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Aligns children with space between
                children: [
                  Expanded(
                    child: buildTextField("Year Level", "", false),
                  ),
                  const SizedBox(
                      width: 5), // Adds space between the text fields
                  Expanded(
                    child: buildTextField("Section", "", false),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Aligns children with space between
                children: [
                  Expanded(
                    child: buildTextField("Institute", "", false),
                  ),
                  const SizedBox(
                      width: 5), // Adds space between the text fields
                  Expanded(
                    child: buildTextField("Course", "", false),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Aligns children with space between
                children: [
                  Expanded(
                    child: buildTextField("Birthdate", "", false),
                  ),
                  const SizedBox(
                      width: 5), // Adds space between the text fields
                  Expanded(
                    child: buildTextField("Gender", "", false),
                  ),
                ],
              ),
              buildTextField("Birthdate", "", false),
              buildTextField("Gender", "", false),
              buildTextField("Current Address", "", false),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
