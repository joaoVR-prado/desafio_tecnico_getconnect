import '../repositories/auth_repository_interface.dart';

class SetupPresenceUsecase {
  final AuthRepositoryInterface repository;

  SetupPresenceUsecase(this.repository);
  Future<void> call(String uid, String name) async {
    await repository.setupPresence(uid, name);
  }
}
