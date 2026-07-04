import 'package:desafio_tecnico_getconnect/core/errors/auth_exceptions.dart';
import 'package:desafio_tecnico_getconnect/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

class AuthRemoteDatasourceImplementation implements AuthRemoteDataSourceInterface {
  final firebase.FirebaseAuth firebaseAuth;

  AuthRemoteDatasourceImplementation(this.firebaseAuth);

  @override
  Future<firebase.User> login(String email, String password) async{
    try{
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email, 
        password: password

      );
      return credential.user!;
    } on firebase.FirebaseAuthException catch (e){
      if(e.code == 'user-not-found' || e.code == 'wrong-passwordd' || e.code == 'invalid-credential'){
        throw InvalidCredentialsException('E-mail ou senha incorretos.');
      } else if(e.code == 'network-request-failed'){
        throw AuthNetworkException('Sem conexão com a internet.');
      }
      throw ServerAuthException('Erro ao realizar login: ${e.message}');

    }
  }

  @override
  Future<firebase.User> register(String name, String email, String password) async{
    try{
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password

      );

      final user = credential.user!;
      await user.updateDisplayName(name);
      return user;

    } on firebase.FirebaseAuthException catch(e){
      if(e.code == 'email-already-in-use'){
        throw EmailAlreadyInUseException('E-mail já cadastrado.');

      } else if(e.code == 'network-request-failed'){
        throw AuthNetworkException('Sem conexão com a internet.');
      }
      throw ServerAuthException('Erro ao cadastrar usuário: ${e.message}');
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();

  }

  @override
  Stream<firebase.User?> get authStateChanges => firebaseAuth.authStateChanges();

}