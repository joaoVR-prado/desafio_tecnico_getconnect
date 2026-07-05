import 'package:desafio_tecnico_getconnect/features/auth/domain/repositories/auth_repository_interface.dart';

class UpdateOnlineStatusUsecase {
  final AuthRepositoryInterface repository;

  UpdateOnlineStatusUsecase(this.repository);

  Future<void> call(String uid, bool isOnline) async{
    await repository.updateOnlineStatus(uid, isOnline);

  }

}