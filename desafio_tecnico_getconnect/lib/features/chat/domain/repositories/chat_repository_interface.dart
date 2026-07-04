import 'package:desafio_tecnico_getconnect/features/chat/domain/entities/message_entity.dart';

abstract class ChatRepositoryInterface {
  Stream<List<MessageEntity>> getMessages();
  Future<void> sendMessage(String senderId, String senderName, String text);

}