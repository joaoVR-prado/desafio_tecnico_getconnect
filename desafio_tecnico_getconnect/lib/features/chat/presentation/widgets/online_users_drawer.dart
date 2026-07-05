import 'package:desafio_tecnico_getconnect/features/chat/presentation/controllers/online_users_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

class OnlineUsersDrawer extends StatelessWidget {
  const OnlineUsersDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnlineUsersController>();

    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.people_outline, 
                    color: Colors.white, 
                    size: 40
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Usuários Online',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              final users = controller.onlineUsers
                .where((user) => user.uid != controller.currentUserId)
                .toList();

              if (users.isEmpty) {
                return const Center(
                  child: Text(
                    'Ninguém online no momento. :('
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];

                  return ListTile(
                    leading: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: Text(
                            user.name.substring(0, 1).toUpperCase(),
                            style: const TextStyle(
                              color: Colors.black87
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    title: Text(user.name),
                    subtitle: const Text(
                      'Online',
                      style: TextStyle(fontSize: 12, color: Colors.green),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
