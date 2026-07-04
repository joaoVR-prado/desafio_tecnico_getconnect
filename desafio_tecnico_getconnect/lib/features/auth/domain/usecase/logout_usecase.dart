import 'package:desafio_tecnico_getconnect/features/auth/domain/repositories/auth_repository_interface.dart';

class LogoutUsecase {
  final AuthRepositoryInterface repository;

  LogoutUsecase(this.repository);

  Future<void> call() async{
    await repository.logout();

  }

}