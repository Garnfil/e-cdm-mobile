import 'package:get/get.dart';
import 'package:mobile/data/models/student_submission_model.dart';
import 'package:mobile/data/services/student_submission_service.dart';

class StudentSubmissionController extends GetxController {
  final StudentSubmissionService studentSubmissionService =
      StudentSubmissionService();

  var student_submission = Rx<StudentSubmission?>(null);
  var isLoading = false.obs;

  @override
  void onInit() {
    // fetchStudentClasses();
    super.onInit();
  }

  void fetchStudentSubmission(schoolWorkId) async {
    isLoading(true);
    try {
      student_submission.value =
          await studentSubmissionService.getStudentSubmission(schoolWorkId);
    } finally {
      isLoading(false);
    }
  }
}
