import 'package:get/get.dart';
import '../../../../data/models/student_login_model.dart';
import '../../../../data/services/student_login_service.dart';

class StudentLoginController extends GetxController {
  final StudentLoginService studentLoginService = StudentLoginService();
  var isLoading = false.obs;

  void submitLogin(StudentLogin studentLogin) async {
    isLoading(true);
    try {
      var data = await studentLoginService.login(studentLogin);
      print(data);
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
