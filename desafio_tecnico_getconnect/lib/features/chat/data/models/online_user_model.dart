import 'package:desafio_tecnico_getconnect/features/chat/domain/entities/online_user_entity.dart';

class OnlineUserModel extends OnlineUserEntity {
  OnlineUserModel({
    required super.uid,
    required super.name,
    required super.isOnline,

  });

  factory OnlineUserModel.fromMap(String uid, Map<dynamic, dynamic> map) {
    return OnlineUserModel(
      uid: uid,
      name: map['name'] ?? 'Desconhecido',
      isOnline: map['state'] == 'online',

    );
  }
}