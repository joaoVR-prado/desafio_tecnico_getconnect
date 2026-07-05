import '../repositories/auth_repository_interface.dart';

class SetupPresenceUsecase {
  final AuthRepositoryInterface repository;

  SetupPresenceUsecase(this.repository);
  void call(String uid, String name) { 
    repository.setupPresence(uid, name);

  }
}