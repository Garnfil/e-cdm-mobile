import 'package:get/get.dart';
import 'package:mobile/data/services/session_service.dart';

class SessionController extends GetxController {
  final SessionService sessionService = SessionService();

  // Observable properties for reactive updates
  var token = ''.obs;
  var user = {}.obs; // Store user info as a Map

  // Method to initialize session
  void initializeSession(String newToken, Map<String, dynamic> newUser) {
    token.value = newToken;
    user.value = newUser;
  }

  // Method to clear session data
  void clearSession() {
    token.value = '';
    user.value = {};
    sessionService.clearSession();
  }
}
