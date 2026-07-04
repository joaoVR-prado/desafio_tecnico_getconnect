abstract class ChatExceptions implements Exception{
  final String message;
  ChatExceptions(this.message);

}

class BlankMessageException extends ChatExceptions{
  BlankMessageException(super.message);

}

class ServerChatException extends ChatExceptions{
  ServerChatException(super.message);

}