import 'package:desafio_tecnico_getconnect/core/errors/auth_exceptions.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/entities/user_entity.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/repositories/auth_repository_interface.dart';

class RegisterUsecase {
  final AuthRepositoryInterface repository;

  RegisterUsecase(this.repository);

  Future<UserEntity> call(String name, String email, String password) async{
    if(name.trim().isEmpty){
      throw InvalidNameException('O nome não pode ser vazio');

    }

    if(name.trim().length < 2){
      throw InvalidNameException('O nome deve conter pelo menos 2 caracteres');

    }

    if(!email.contains('@')){
      throw InvalidEmailException('E-mail com formato inválido');

    }

    if(password.length < 8){
      throw InvalidPasswordException('A senha deve ter pelo menos 8 caracteres');

    }

    return await repository.register(name, email, password);

  }

}