import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/common/widgets/appbar/appbar.dart';
import 'package:mobile/features/student/screens/classes/classroom.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';

class ClassesScreen extends StatelessWidget {
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.primaryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// App Bar
              TAppBar(
                title: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Class List',
                        style: TextStyle(
                          fontSize: TSizes.fontSize2Xl,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ]),
                showBackArrow: false,
                actions: [
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Iconsax
                            .notification), // Replace with your image asset
                        onPressed: () {},
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: TColors.black,
                              borderRadius: BorderRadius.circular(100)),
                          child: const Center(
                            child: Text(
                              '2',
                              style: TextStyle(color: TColors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),

              /// Content Body
              Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    /// Classes Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.mail,
                            color: TColors.buttonPrimary,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.add_circle,
                            color: TColors.buttonPrimary,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),

                    /// Space between icons and list
                    const SizedBox(height: TSizes.defaultSpace),

                    /// Classes List
                    /// Wrapping ListView in a SizedBox with a defined height
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView(
                        children: const [
                          CourseCard(
                            courseName: 'IT-ELECT',
                            instructorName: 'Mr. Joe F. Maciling',
                          ),
                          SizedBox(height: 10),
                          CourseCard(
                            courseName: 'QM',
                            instructorName: 'Mr. Joe F. Maciling',
                          ),
                          SizedBox(height: 10),
                          CourseCard(
                            courseName: 'CAPSTONE 1',
                            instructorName: 'Mr. Joe F. Maciling',
                          ),
                          SizedBox(height: 10),
                          CourseCard(
                            courseName: 'SA',
                            instructorName: 'Ms. Sheena F. George',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String courseName;
  final String instructorName;

  const CourseCard({
    super.key,
    required this.courseName,
    required this.instructorName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => const ClassRoomScreen()),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: Colors.black, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      courseName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      instructorName,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const CircleAvatar(
                radius: 20,
                backgroundColor: TColors.primaryColor,
                child: Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
