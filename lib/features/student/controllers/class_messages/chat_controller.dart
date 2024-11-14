import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/controllers/session_controller.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatController extends GetxController {
  final String _baseUrl = 'https://e-learn.godesqsites.com/api';
  final SessionController sessionController = Get.put(SessionController());
  final int classId;

  final messages = <Map<String, dynamic>>[].obs;
  final TextEditingController messageController = TextEditingController();
  late PusherChannelsFlutter pusher;

  ChatController({required this.classId});

  @override
  void onInit() {
    super.onInit();
    connectToPusher();
    fetchMessages();
  }

  @override
  void onClose() {
    pusher.unsubscribe(channelName: 'class.message.$classId');
    super.onClose();
  }

  void fetchMessages() async {
    final token = sessionController.token;
    final response = await http.get(
      Uri.parse('$_baseUrl/messages/classes/$classId'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      messages.value =
          List<Map<String, dynamic>>.from(jsonResponse['messages']);
    }
  }

  void connectToPusher() async {
    pusher = PusherChannelsFlutter.getInstance();
    await pusher.init(
      apiKey: 'dcb5e22ff8f02d72a547',
      cluster: 'ap1',
      onEvent: onMessageReceived,
      onError: onError,
    );

    try {
      await pusher.subscribe(
        channelName: "class.message.$classId",
      );

      log("trying to subscribe to :  class.message.$classId");
    } catch (e) {
      log(e.toString());
    }

    await pusher.connect();
  }

  void onError(String message, int? code, dynamic e) {
    log("onError: $message code: $code exception: $e");
  }

  void onMessageReceived(PusherEvent event) {
    if (event.eventName == 'new-class-message') {
      print('Received event data: ${event.data}');
      final newMessage = jsonDecode(event.data!);
      messages.add({
        'user': newMessage['user'],
        'content': newMessage['content'],
        'created_at': newMessage['created_at'],
      });
    }
  }

  Future<void> sendMessage(String message) async {
    final token = sessionController.token;
    final response = await http.post(
      Uri.parse('$_baseUrl/messages/classes/$classId'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'user_id': sessionController.user['id'],
        'user_type': sessionController.user['role'],
        'content': message,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      final newMessage = jsonDecode(response.body);
      messages.add({
        'user': newMessage['user'],
        'content': newMessage['content'],
        'created_at': newMessage['created_at'],
      });
    }
  }
}
