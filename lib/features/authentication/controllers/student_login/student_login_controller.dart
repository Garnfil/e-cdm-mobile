import 'package:get/get.dart';
import 'package:mobile/navigation_menu.dart';
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
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
