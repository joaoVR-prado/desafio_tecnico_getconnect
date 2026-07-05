import 'package:desafio_tecnico_getconnect/features/chat/data/models/online_user_model.dart';
import 'package:desafio_tecnico_getconnect/features/chat/domain/entities/online_user_entity.dart';
import 'package:desafio_tecnico_getconnect/features/chat/domain/repositories/online_users_repository_interface.dart';
import 'package:firebase_database/firebase_database.dart';

class OnlineUsersRepositoryImplementation implements OnlineUsersRepositoryInterface {
  final FirebaseDatabase database;

  OnlineUsersRepositoryImplementation(this.database);

  @override
  Stream<List<OnlineUserEntity>> getOnlineUsersStream(){
    return database.ref('status').onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data == null) return [];

      List<OnlineUserEntity> users = [];
      data.forEach((key, value) {
        if (value['state'] == 'online') {
          users.add(OnlineUserModel.fromMap(key, value));
          
        }
      });
      return users;

    });

  }

}