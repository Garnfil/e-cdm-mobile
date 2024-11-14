import 'package:get/get.dart';
import 'package:mobile/data/models/school_work_model.dart';
import 'package:mobile/data/services/school_work_service.dart';

class SchoolWorkController extends GetxController {
  final SchoolWorkService schoolWorkService = SchoolWorkService();

  var schoolWorks = <SchoolWork>[].obs;
  var isLoading = false.obs;
  var singleSchoolWork = Rx<SchoolWork?>(null);

  Future<void> fetchStudentSchoolWorks(int classId) async {
    isLoading(true);
    try {
      schoolWorks.value =
          await schoolWorkService.getStudentSchoolWorks(classId);
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchStudentTodosSchoolWorks(int classId) async {
    isLoading(true);
    try {
      schoolWorks.value = await schoolWorkService.getTodosSchoolWorks(classId);
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchStudentCompletedSchoolWorks(int classId) async {
    isLoading(true);
    try {
      schoolWorks.value =
          await schoolWorkService.getCompletedSchoolWorks(classId);
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchStudentMissingSchoolWorks(int classId) async {
    isLoading(true);
    try {
      schoolWorks.value =
          await schoolWorkService.getMissingSchoolWorks(classId);
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchSingleSchoolWork(int schoolWorkId) async {
    isLoading(true);
    try {
      singleSchoolWork.value =
          await schoolWorkService.getSingleSchoolWork(schoolWorkId);
    } finally {
      isLoading(false);
    }
  }
}
