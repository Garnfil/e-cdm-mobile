import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/common/widgets/appbar/appbar.dart';
import 'package:mobile/features/student/screens/home/widgets/home_calendar.dart';
import 'package:mobile/features/student/screens/home/widgets/upcoming_schedules.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.primaryBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            TAppBar(
              title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${TText.homeAppbarTitle},',
                      style: TextStyle(fontSize: TSizes.fontSizeLg)),
                  Text("Student", style: TextStyle(fontSize: TSizes.fontSizeLg))
                ],
              ),
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
            const SizedBox(height: TSizes.sm),

            /// Body Content
            const Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Calendar
                  HomeCalendar(),

                  SizedBox(height: TSizes.spaceBtwItems),

                  /// Upcoming Schedules
                  UpcomingSchedulesList()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
