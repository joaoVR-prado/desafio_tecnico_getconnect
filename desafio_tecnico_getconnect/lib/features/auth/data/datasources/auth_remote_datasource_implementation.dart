import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_tecnico_getconnect/core/errors/auth_exceptions.dart';
import 'package:desafio_tecnico_getconnect/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

class AuthRemoteDatasourceImplementation implements AuthRemoteDataSourceInterface {
  final firebase.FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDatasourceImplementation(this.firebaseAuth, this.firestore);

  @override
  Future<firebase.User> login(String email, String password) async{
    try{
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email, 
        password: password

      );

      await updateOnlineStatus(credential.user!.uid, true);

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
      await firestore.collection('users').doc(user.uid).set({
        'id': user.uid,
        'name': name,
        'email': email,
        'isOnline': true

      });

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
    final user = firebaseAuth.currentUser;
    if(user != null){
      await updateOnlineStatus(user.uid, false);

    }
    
    await firebaseAuth.signOut();

  }

  @override
  Stream<firebase.User?> get authStateChanges => firebaseAuth.authStateChanges();

  @override
  Future<void> updateOnlineStatus(String uid, bool isOnline) async{
    await firestore.collection('users').doc(uid).set({
      'isOnline': isOnline,
      'lastSeen': FieldValue.serverTimestamp()

    }, SetOptions(merge: true));

  }

}