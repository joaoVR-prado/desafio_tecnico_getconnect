import 'package:desafio_tecnico_getconnect/features/chat/domain/entities/online_user_entity.dart';

abstract class OnlineUsersRepositoryInterface {
  Stream<List<OnlineUserEntity>> getOnlineUsersStream();

}