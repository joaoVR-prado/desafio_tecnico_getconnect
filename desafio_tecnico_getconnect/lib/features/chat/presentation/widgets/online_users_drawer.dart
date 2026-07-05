import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_tecnico_getconnect/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class OnlineUsersDrawer extends StatelessWidget {
  const OnlineUsersDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId = Get.find<AuthController>().currentUser.value?.id;

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
                    size: 40,

                  ),
                  SizedBox(height: 12),
                  Text(
                    'Usuários Online',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold

                    ),
                  )
                ],
              ),
            )
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                .collection('users')
                .where('isOnline', isEqualTo: true)
                .snapshots(), 
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());

                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('Ninguém online no momento. :('));

                }

                final users = snapshot.data!.docs;

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: users.length,
                  itemBuilder: (context, index){
                    final userData = users[index].data() as Map<String, dynamic>;
                    final uid = userData['id'];
                    final name = userData['name'] ?? 'Desconhecido';

                    if(uid == currentUserId) return const SizedBox.shrink();

                    return ListTile(
                      leading: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: Text(
                              name.substring(0, 1).toUpperCase(),
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
                                border: Border.all(
                                  color: Colors.white, 
                                  width: 2
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      title: Text(name),
                      subtitle: const Text(
                        'Online', 
                        style: TextStyle(
                          fontSize: 12, 
                          color: Colors.green
                        )
                      ),
                    );  
                  }
                );
              }
            )
          )
        ],
      ),
    );
  }

}