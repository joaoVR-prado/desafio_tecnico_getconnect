import 'package:desafio_tecnico_getconnect/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email

  });

  factory UserModel.fromFirebaseUser(firebase.User firebaseUser, {String name = ''}){
    return UserModel(
      id: firebaseUser.uid, 
      name: firebaseUser.displayName ?? name, 
      email: firebaseUser.email ?? ''

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'email': email

    };
  }

}