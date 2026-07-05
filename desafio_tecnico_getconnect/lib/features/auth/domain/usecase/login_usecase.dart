import 'package:desafio_tecnico_getconnect/core/errors/auth_exceptions.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/entities/user_entity.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/repositories/auth_repository_interface.dart';

class LoginUsecase {
  final AuthRepositoryInterface repository;

  LoginUsecase(this.repository);

  Future<UserEntity> call(String email, String password) async{
    if (email.trim().isEmpty || password.trim().isEmpty) {
      throw InvalidCredentialsException('Preencha o e-mail e a senha.');
      
    }
    if(!email.contains('@')){
      throw InvalidEmailException('E-mail com formato inválido');

    }

    return await repository.login(email, password);

  }

}