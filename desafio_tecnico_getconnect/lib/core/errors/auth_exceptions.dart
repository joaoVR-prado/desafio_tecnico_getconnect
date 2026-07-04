abstract class AuthExceptions implements Exception{
  final String message;
  AuthExceptions(this.message); 

}

class InvalidNameException extends AuthExceptions{
  InvalidNameException(super.message);

}

class InvalidEmailExcption extends AuthExceptions{
  InvalidEmailExcption(super.message);

}

class InvalidPasswordException extends AuthExceptions{
  InvalidPasswordException(super.message);

}