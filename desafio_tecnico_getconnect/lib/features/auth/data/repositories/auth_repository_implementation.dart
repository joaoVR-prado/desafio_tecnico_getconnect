import 'package:desafio_tecnico_getconnect/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:desafio_tecnico_getconnect/features/auth/data/models/user_model.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/entities/user_entity.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/repositories/auth_repository_interface.dart';

class AuthRepositoryImplementation implements AuthRepositoryInterface {
  final AuthRemoteDataSourceInterface remoteDataSource;

  AuthRepositoryImplementation(this.remoteDataSource);

  @override
  Future<UserEntity> login(String email, String password) async{
    final firebaseUser = await remoteDataSource.login(email, password);
    return UserModel.fromFirebaseUser(firebaseUser);

  }

  @override
  Future<UserEntity> register(String name, String email, String password) async{
    final firebaseUser = await remoteDataSource.register(name, email, password);
    return UserModel.fromFirebaseUser(firebaseUser, name: name);

  }

  @override
  Future<void> logout() async{
    await remoteDataSource.logout();

  }

  @override
  Stream<UserEntity?> get authStateChanges{
    return remoteDataSource.authStateChanges.map((firebaseUser){
      if(firebaseUser == null) return null;
      return UserModel.fromFirebaseUser(firebaseUser);

    });

  }

  @override
  void setupPresence(String uid, String name) {
    remoteDataSource.setupPresenceSystem(uid, name);
    
  }

}