import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/common/widgets/appbar/appbar.dart';
import 'package:mobile/features/student/screens/school_works/school_work.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';

class ClassRoomScreen extends StatelessWidget {
  const ClassRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: TColors.primaryBackground,
        body: SafeArea(
          child: Column(
            children: [
              /// AppBar
              TAppBar(
                title: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Class',
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

              /// Class Header
              Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xff0B4D10),
                            Color(0xffFFC900)
                          ], // Define the colors for the gradient
                          begin: Alignment
                              .topLeft, // Starting point of the gradient
                          end: Alignment
                              .bottomRight, // Ending point of the gradient
                        ),
                        border: Border.all(color: TColors.black, width: 2),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BSIT - 3H',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'IT ELECT',
                            style: TextStyle(
                                fontSize: TSizes.fontSize3Xl,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// Tab Bar
                    const TabBar(
                      indicatorColor: TColors.primaryColor,
                      isScrollable: true,
                      unselectedLabelColor: Colors.grey,
                      tabAlignment: TabAlignment.start,
                      tabs: [
                        Tab(child: Text("To Do's")),
                        Tab(child: Text('Completed')),
                        Tab(child: Text('Missing')),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                  ],
                ),
              ),

              /// Tab Bar View (wrapped in an Expanded to give it height)
              /// Tab Bar View (wrapped in an Expanded to give it height)
              Expanded(
                child: TabBarView(
                  children: [
                    /// Content for 'To Do' tab
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, // Assuming a default padding
                      ),
                      child: ListView(
                        children: const [
                          SchoolWorkCard(
                            title: 'Assignment #1',
                            points: '10',
                            dueDate: 'Oct 11, 2024',
                            schoolWorkType: 'assignment',
                          ),
                          SizedBox(height: 5),
                          SchoolWorkCard(
                            title: 'Quiz #1',
                            points: '30',
                            dueDate: 'Oct 11, 2024',
                            schoolWorkType: 'quiz',
                          ),
                          SizedBox(height: 5),
                          SchoolWorkCard(
                            title: 'Activity #1',
                            points: '30',
                            dueDate: 'Oct 11, 2024',
                            schoolWorkType: 'activity',
                          ),
                        ],
                      ),
                    ),

                    /// Content for 'Completed' tab
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace,
                      ),
                      child: const Text('To Do'),
                    ),

                    /// Content for 'Missing' tab
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace,
                      ),
                      child: const Text('To Do'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SchoolWorkCard extends StatelessWidget {
  final String title;
  final String points;
  final String dueDate;
  final String schoolWorkType;

  const SchoolWorkCard({
    super.key,
    required this.title,
    required this.points,
    required this.dueDate,
    required this.schoolWorkType,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => const SchoolWorkScreen()),
      child: Card(
        margin: const EdgeInsets.all(10),
        elevation: 3,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// School Work Details (Left Side)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Points: $points',
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Due Date: $dueDate',
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),

              /// School Work Type Badge (Right Side)
              Chip(
                label: Text(
                  schoolWorkType.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: const Color(0xffFFC900),
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: const BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
