import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/controllers/session_controller.dart';
import 'package:mobile/features/student/controllers/class_messages/chat_controller.dart';
import 'package:mobile/utils/constants/colors.dart';

class ClassChatBoxScreen extends StatelessWidget {
  final int classId;

  const ClassChatBoxScreen({super.key, required this.classId});

  @override
  Widget build(BuildContext context) {
    final ChatController chatController =
        Get.put(ChatController(classId: classId));

    final SessionController sessionController = Get.put(SessionController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BSIT 3H - IT ELECT',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            Text(
              '40 members, 5 online',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              // chatController.fetchMessages();

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  final message = chatController.messages[index];
                  return ChatBubble(
                    message: message['content'],
                    time: message['created_at'],
                    isMe:
                        message['user']['id'] == sessionController.user['id'] &&
                            message['user']['role'] ==
                                sessionController.user['role'],
                    sender:
                        "${message['user']['firstname']} ${message['user']['lastname']}",
                    avatar: message['user']['avatar'] ??
                        "https://via.placeholder.com/150",
                  );
                },
              );
            }),
          ),
          ChatInputField(
            classId: classId,
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isMe;
  final String sender;
  final String avatar;

  ChatBubble({
    required this.message,
    required this.time,
    required this.isMe,
    required this.sender,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isMe)
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(avatar),
                ),
              if (!isMe) const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      sender,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 14),
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: isMe ? TColors.primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Text(
                      message,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              if (isMe) const SizedBox(width: 8),
              if (isMe)
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(avatar),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                left: isMe ? 0 : 48, right: isMe ? 48 : 0, top: 4),
            child: Text(
              time,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class ChatInputField extends StatelessWidget {
  final int classId;
  final TextEditingController messageController = TextEditingController();

  ChatInputField({super.key, required this.classId});

  @override
  Widget build(BuildContext context) {
    // Instantiate ChatController here
    final ChatController chatController =
        Get.put(ChatController(classId: classId));

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: const InputDecoration(
                hintText: "Write your message",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.green),
            onPressed: () {
              if (messageController.text.isNotEmpty) {
                chatController.sendMessage(messageController.text);
                messageController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
