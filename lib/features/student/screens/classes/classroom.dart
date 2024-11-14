import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/common/widgets/appbar/action_notification.dart';
import 'package:mobile/common/widgets/appbar/appbar.dart';
import 'package:mobile/data/models/school_work_model.dart';
import 'package:mobile/features/student/controllers/classes/class_controller.dart';
import 'package:mobile/features/student/controllers/classes/school_work_controller.dart';
import 'package:mobile/features/student/screens/classes/widget/class_header.dart';
import 'package:mobile/features/student/screens/classes/widget/school_work_card.dart';
import 'package:mobile/features/student/screens/school_works/school_work.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/formatters/formatter.dart';

class ClassRoomScreen extends StatefulWidget {
  final int classroomId;
  final ClassController classController = Get.put(ClassController());

  ClassRoomScreen({super.key, required this.classroomId});

  @override
  _ClassRoomScreenState createState() => _ClassRoomScreenState();
}

class _ClassRoomScreenState extends State<ClassRoomScreen>
    with SingleTickerProviderStateMixin {
  final SchoolWorkController controller = Get.put(SchoolWorkController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    // Initialize TabController and add listener
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);

    // Initial fetch for the first tab
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchStudentTodosSchoolWorks(widget.classroomId);
      widget.classController.fetchSingleClass(widget.classroomId);
    });
  }

  // Handle tab change to fetch data accordingly
  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 0:
          controller.fetchStudentTodosSchoolWorks(widget.classroomId);
          break;
        case 1:
          controller.fetchStudentCompletedSchoolWorks(widget.classroomId);
          break;
        case 2:
          controller.fetchStudentMissingSchoolWorks(widget.classroomId);
          break;
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTabContent(RxList<SchoolWork> schoolWorks) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Check if there are no school works
        if (schoolWorks.isEmpty) {
          return const Center(child: Text('No school works available.'));
        }

        return ListView.builder(
          itemCount: schoolWorks.length,
          itemBuilder: (context, index) {
            final schoolWork = schoolWorks[index];
            return SchoolWorkCard(
              schoolWorkId: schoolWork.id,
              title: schoolWork.title,
              dueDate: schoolWork.dueDatetime.toString(),
              schoolWorkType: schoolWork.type,
            );
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            /// AppBar
            const TAppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Class',
                    style: TextStyle(
                      fontSize: TSizes.fontSize2Xl,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              showBackArrow: false,
            ),

            /// Class Header
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Obx(
                () {
                  final singleClass = widget.classController.singleClass.value;

                  return Column(
                    children: [
                      ClassHeader(
                        classRoom: singleClass,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      /// Tab Bar
                      TabBar(
                        controller: _tabController,
                        indicatorColor: TColors.primaryColor,
                        isScrollable: true,
                        unselectedLabelColor: Colors.grey,
                        tabs: const [
                          Tab(child: Text("To Do's")),
                          Tab(child: Text('Completed')),
                          Tab(child: Text('Missing')),
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                    ],
                  );
                },
              ),
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  /// 'To Do' tab content
                  _buildTabContent(controller.schoolWorks),

                  /// 'Completed' tab content
                  _buildTabContent(controller.schoolWorks),

                  /// 'Missing' tab content
                  _buildTabContent(controller.schoolWorks),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
