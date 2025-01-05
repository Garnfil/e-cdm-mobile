import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/data/controllers/session_controller.dart';
import 'package:mobile/features/authentication/screens/student_info_registration/student_info_registration.dart';
import 'package:mobile/features/student/screens/class_schedules/class_schedules.dart';
import 'package:mobile/features/student/screens/classes/classes.dart';
import 'package:mobile/features/student/screens/home.dart';
import 'package:mobile/features/student/screens/profile/profile.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.put(NavigationController());
    final sessionController =
        Get.find<SessionController>(); // Find controller if already initialized

    // Check if 'is_first_login' exists, then update it
    if (sessionController.user['is_first_login'] == 1) {
      // Navigate to the registration screen directly without returning a widget
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAll(() =>
            const StudentInfoRegistration()); // Ensures it replaces the current screen
      });
      return const SizedBox(); // Return an empty widget while navigation occurs
    }

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: navigationController.selectedIndex.value,
          onDestinationSelected: (index) =>
              navigationController.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Iconsax.document), label: 'Classes'),
            NavigationDestination(
                icon: Icon(Iconsax.calendar), label: 'Schedules'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(
        () => navigationController
            .screens[navigationController.selectedIndex.value],
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const StudentHomeScreen(),
    ClassesScreen(), // Added `const` for consistency
    const CalendarPage(),
    const EditProfilePage(),
  ];
}
