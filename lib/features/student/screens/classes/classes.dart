import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/common/widgets/appbar/appbar.dart';
import 'package:mobile/features/student/controllers/classes/class_controller.dart';
import 'package:mobile/features/student/screens/classes/classroom.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';

class ClassesScreen extends StatelessWidget {
  final ClassController controller = Get.put(ClassController());
  final _classCodeController = TextEditingController();

  ClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.primaryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// App Bar
              const TAppBar(
                title: Column(
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
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                                child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    'Join Class',
                                    style:
                                        TextStyle(fontSize: TSizes.fontSizeXl),
                                  ),
                                  TextField(
                                      controller: _classCodeController,
                                      decoration: const InputDecoration(
                                          hintText: "Enter class code")),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Close'),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              TColors.buttonPrimary,
                                          foregroundColor: TColors.white,
                                          shape: const RoundedRectangleBorder(
                                            side: BorderSide(
                                              color:
                                                  Colors.black, // Border color
                                              width: 2, // Border thickness
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ), // Square edges for a brutalist look
                                          ),
                                        ),
                                        onPressed: () {
                                          controller.joinClass(
                                              _classCodeController.text);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Join Class'),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),

                    /// Space between icons and list
                    const SizedBox(height: TSizes.defaultSpace),

                    /// Classes List
                    /// Wrapping ListView in a SizedBox with a defined height
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Obx(() => ListView.separated(
                            itemCount: controller.classes.length,
                            itemBuilder: (context, index) {
                              final classRoom = controller.classes[index];
                              return CourseCard(
                                  classroomId: classRoom.id,
                                  courseName: classRoom.title,
                                  instructorName:
                                      classRoom.instructorId.toString());
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                    height: 10), // Space between items
                          )),
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
  final int classroomId;
  final String courseName;
  final String instructorName;

  const CourseCard({
    super.key,
    required this.courseName,
    required this.instructorName,
    required this.classroomId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ClassRoomScreen(
            classroomId: classroomId,
          )),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: Colors.black, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      courseName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
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
