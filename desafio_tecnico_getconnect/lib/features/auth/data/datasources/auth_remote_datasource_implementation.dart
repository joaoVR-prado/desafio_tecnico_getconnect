import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_tecnico_getconnect/core/errors/auth_exceptions.dart';
import 'package:desafio_tecnico_getconnect/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:firebase_database/firebase_database.dart';

class AuthRemoteDatasourceImplementation implements AuthRemoteDataSourceInterface {
  final firebase.FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final FirebaseDatabase realtimeDatabase;

  AuthRemoteDatasourceImplementation(this.firebaseAuth, this.firestore, this.realtimeDatabase);

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
      await firestore.collection('users').doc(user.uid).set({
        'id': user.uid,
        'name': name,
        'email': email,

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
      await realtimeDatabase.ref("status/${user.uid}").set({
        "state": "offline",
        "name": user.displayName ?? '',
        "last_changed": ServerValue.timestamp,
      });
    }
    await firebaseAuth.signOut();

  }

  @override
  Stream<firebase.User?> get authStateChanges => firebaseAuth.authStateChanges();

  @override
  void setupPresenceSystem(String uid, String name) {
    final DatabaseReference presenceRef = realtimeDatabase.ref("status/$uid");

    realtimeDatabase.ref(".info/connected").onValue.listen((event) async {
      final bool connected = event.snapshot.value as bool? ?? false;

      if (connected) {
        await presenceRef.onDisconnect().set({
          "state": "offline",
          "name": name,
          "last_changed": ServerValue.timestamp,
        });

        await presenceRef.set({
          "state": "online",
          "name": name,
          "last_changed": ServerValue.timestamp,
        });
      }
    });
  }

}