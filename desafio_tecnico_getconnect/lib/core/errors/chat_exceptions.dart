abstract class ChatExceptions implements Exception{
  final String message;
  ChatExceptions(this.message);

}

class BlankMessageException extends ChatExceptions{
  BlankMessageException(super.message);

}