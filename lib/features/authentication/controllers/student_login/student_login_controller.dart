import 'package:get/get.dart';
import 'package:mobile/features/authentication/screens/student_info_registration/student_info_registration.dart';
import 'package:mobile/navigation_menu.dart';
import 'package:mobile/utils/constants/colors.dart';
import '../../../../data/models/student_login_model.dart';
import '../../../../data/services/student_login_service.dart';
import '../../../../data/controllers/session_controller.dart';

class StudentLoginController extends GetxController {
  final StudentLoginService studentLoginService = StudentLoginService();
  final SessionController sessionController = Get.find<SessionController>();

  var isLoading = false.obs;

  void submitLogin(StudentLogin studentLogin) async {
    isLoading(true);
    try {
      var data = await studentLoginService.login(studentLogin);
      // Initialize session using data from the login response
      sessionController.initializeSession(data['token'], data['user']);

      // print("Logged in successfully: ${data['user']}");
      Get.snackbar('Success', "Login Successfully!");
      Get.to(const NavigationMenu());
      // Get.to(const StudentInfoRegistration());
    } catch (e) {
      isLoading(false);
      Get.snackbar(
        'Failed', // Title
        e.toString(), // Message
        snackPosition: SnackPosition.TOP, // Position: TOP or BOTTOM
        backgroundColor: TColors.error, // Background color
        colorText: TColors.white, // Text color
        borderRadius: 8.0, // Border radius
        duration: const Duration(seconds: 4), // Duration to display
        isDismissible: true, // Allow dismissal
      );
    } finally {
      isLoading(false);
    }
  }
}
