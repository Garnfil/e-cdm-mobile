import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/data/controllers/session_controller.dart';
import 'package:mobile/data/services/session_service.dart';
import 'package:mobile/data/services/submission_attachment_service.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  final sessionService = SessionService();
  final sessionController = Get.put(SessionController());

  // Load saved session
  final savedSession = sessionService.loadSession();
  if (savedSession != null) {
    sessionController.initializeSession(
        savedSession['token'], savedSession['user']);
  }

  Get.put(SubmissionAttachmentService()); // Add this line

  runApp(App(hasSession: savedSession != null));
}
