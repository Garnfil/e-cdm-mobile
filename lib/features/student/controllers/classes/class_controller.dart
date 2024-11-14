import 'package:get/get.dart';
import 'package:mobile/data/models/class_model.dart';
import 'package:mobile/data/services/classes_service.dart';

class ClassController extends GetxController {
  final ClassService classService = ClassService();

  var classes = <ClassRoom>[].obs;
  var singleClass = Rx<ClassRoom?>(null);
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchStudentClasses();
    super.onInit();
  }

  void fetchSingleClass(classId) async {
    isLoading(true);
    try {
      singleClass.value = await classService.getClassDetails(classId);
    } finally {
      isLoading(false);
    }
  }

  void fetchStudentClasses() async {
    isLoading(true);
    try {
      classes.value = await classService.getStudentClasses();
    } finally {
      isLoading(false);
    }
  }

  void fetchClassSchoolWorks() async {
    isLoading(true);
    try {} finally {
      isLoading(false);
    }
  }

  void joinClass(String classCode) async {
    isLoading(true);
    try {
      await classService.joinClass(classCode);
      fetchStudentClasses(); // Refresh classes after joining
      Get.snackbar("Success", "You have successfully joined the class.");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to join class. Please try again.");
    } finally {
      isLoading(false);
    }
  }
}
