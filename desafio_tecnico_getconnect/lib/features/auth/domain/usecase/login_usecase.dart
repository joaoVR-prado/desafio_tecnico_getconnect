import 'package:desafio_tecnico_getconnect/core/errors/auth_exceptions.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/entities/user_entity.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/repositories/auth_repository_interface.dart';

class LoginUsecase {
  final AuthRepositoryInterface repository;

  LoginUsecase(this.repository);

  Future<UserEntity> call(String email, String password) async{
    if(!email.contains('@')){
      throw InvalidEmailExcption('E-mail com formato inválido');
    }
    if(password.length < 8){
      throw InvalidPasswordException('A senha deve conter pelo menos 8 caracteres');
    }

    return await repository.login(email, password);

  }

}