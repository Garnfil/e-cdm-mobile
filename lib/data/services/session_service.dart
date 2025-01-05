import 'package:get_storage/get_storage.dart';

class SessionService {
  final GetStorage storage = GetStorage();

  // Save session data
  void saveSession(String token, user) {
    storage.write('token', token);
    storage.write('user', user);
  }

  // Load session data
  Map<String, dynamic>? loadSession() {
    String? token = storage.read('token');
    Map<String, dynamic>? user = storage.read('user');
    return (token != null && user != null)
        ? {'token': token, 'user': user}
        : null;
  }

  // Clear session data
  void clearSession() {
    storage.remove('token');
    storage.remove('user');
  }
}
