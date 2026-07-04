abstract class AuthExceptions implements Exception{
  final String message;
  AuthExceptions(this.message); 

}

// Exceções de Domínio
class InvalidNameException extends AuthExceptions{
  InvalidNameException(super.message);

}

class InvalidEmailExcption extends AuthExceptions{
  InvalidEmailExcption(super.message);

}

class InvalidPasswordException extends AuthExceptions{
  InvalidPasswordException(super.message);

}

// Exceções do Firebase
class InvalidCredentialsException extends AuthExceptions {
  InvalidCredentialsException(super.message);
  
}

class EmailAlreadyInUseException extends AuthExceptions {
  EmailAlreadyInUseException(super.message);

}

class AuthNetworkException extends AuthExceptions {
  AuthNetworkException(super.message);

}

class ServerAuthException extends AuthExceptions {
  ServerAuthException(super.message);

}