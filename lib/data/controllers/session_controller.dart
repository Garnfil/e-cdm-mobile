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

  // Method to update user and save changes to storage
  void updateUser(String key, dynamic value) {
    user[key] = value; // Update the RxMap
    user.refresh(); // Trigger reactive updates

    // Save the updated user data to storage
    sessionService.saveSession(token.value, user);
  }

  // Method to clear session data
  void clearSession() {
    token.value = '';
    user.value = {};
    sessionService.clearSession();
  }
}
