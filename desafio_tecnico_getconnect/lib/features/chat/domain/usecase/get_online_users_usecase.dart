import 'package:desafio_tecnico_getconnect/features/chat/domain/entities/online_user_entity.dart';
import 'package:desafio_tecnico_getconnect/features/chat/domain/repositories/online_users_repository_interface.dart';

class GetOnlineUsersUsecase {
  final OnlineUsersRepositoryInterface repository;

  GetOnlineUsersUsecase(this.repository);

  Stream<List<OnlineUserEntity>> call(){
    return repository.getOnlineUsersStream();

  }

}