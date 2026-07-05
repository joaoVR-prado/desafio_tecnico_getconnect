import 'package:desafio_tecnico_getconnect/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepositoryInterface {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register(String name, String email, String password);
  Future<void> logout();
  Stream<UserEntity?> get authStateChanges;
  void setupPresence(String uid, String name);

}