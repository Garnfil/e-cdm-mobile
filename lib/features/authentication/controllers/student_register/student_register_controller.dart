import 'package:get/get.dart';
import 'package:mobile/data/models/student_register_model.dart';
import 'package:mobile/data/services/student_register_service.dart';
import 'package:mobile/features/authentication/screens/register/verify_email.dart';

import '../../../../data/controllers/session_controller.dart';

class StudentRegisterController extends GetxController {
  final StudentRegisterService studentRegisterService =
      StudentRegisterService();
  final SessionController sessionController = Get.find<SessionController>();

  var isLoading = false.obs;

  void submitRegistration(StudentRegister studentRegister) async {
    isLoading(true);
    try {
      var data = await studentRegisterService.register(studentRegister);
      print(data);
      // Initialize session using data from the login response
      // sessionController.initializeSession(data['token'], data['user']);

      // print("Logged in successfully: ${data['user']}");
      Get.snackbar('Success', "Register Successfully!");
      Get.to(const VerifyEmailScreen());
    } catch (e) {
      print(e);
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
