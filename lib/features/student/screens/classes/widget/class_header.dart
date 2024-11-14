import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/models/class_model.dart';
import 'package:mobile/features/student/screens/attendances/attendances.dart';
import 'package:mobile/features/student/screens/class_messages/class_chat_box.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/colors.dart';

class ClassHeader extends StatelessWidget {
  final ClassRoom? classRoom;
  const ClassHeader({
    super.key,
    required this.classRoom,
  });

  @override
  Widget build(BuildContext context) {
    if (classRoom == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff0B4D10), Color(0xffFFC900)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: TColors.black, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(classRoom!.currentAssessmentCategory,
              style: const TextStyle(color: Colors.white)),
          Text(
            classRoom!.title,
            style: const TextStyle(
              fontSize: TSizes.fontSizeXl,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              TextButton(
                style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
                ),
                onPressed: () {
                  Get.to(ClassAttedanceScreen(classId: classRoom!.id));
                },
                child: const Text(
                  'Attendance',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              TextButton(
                style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
                ),
                onPressed: () {
                  Get.to(ClassChatBoxScreen(
                    classId: classRoom!.id,
                  ));
                },
                child: const Text(
                  'Messages',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              // TextButton(
              //   style: const ButtonStyle(
              //     padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
              //   ),
              //   onPressed: () {},
              //   child: const Text(
              //     'Schedules',
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontWeight: FontWeight.w400,
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
