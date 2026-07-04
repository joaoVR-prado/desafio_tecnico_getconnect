import 'package:firebase_auth/firebase_auth.dart' as firebase;

abstract class AuthRemoteDataSourceInterface {
  Future<firebase.User> login(String email, String password);
  Future<firebase.User> register(String name, String email, String password);
  Future<void> logout();
  Stream<firebase.User?> get authStateChanges;

}