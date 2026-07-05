import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';
import '../../../../core/routes/app_routes.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await controller.authController.logout();
              Get.offAllNamed(AppRoutes.login);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.messages.isEmpty) {
                return const Center(child: Text(
                  'Nenhuma mensagem ainda. Envie uma agora!'
                ));
              }
              return ListView.builder(
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  final isMe = message.senderId == controller.authController.currentUser.value?.id;
                  final timeString = '${message.timestamp.hour.toString().padLeft(2, '0')}:${message.timestamp.minute.toString().padLeft(2, '0')}';
                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blue[100] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isMe) ...[
                            Text(
                              message.senderName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold, 
                                fontSize: 12, 
                                color: Colors.blue[800],
                              ),
                            ),
                            const SizedBox(height: 4),
                          ],
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 48.0, bottom: 12.0),
                                child: Text(
                                  message.text,
                                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      timeString,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.black54, 
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.textController,
                    onChanged: (val) => controller.messageText.value = val, 
                    decoration: const InputDecoration(
                      hintText: 'Digite sua mensagem...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Obx(() => ElevatedButton(
                  onPressed: controller.messageText.value.trim().isEmpty
                    ? null
                    : () => controller.sendMessage(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Icon(Icons.send),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}