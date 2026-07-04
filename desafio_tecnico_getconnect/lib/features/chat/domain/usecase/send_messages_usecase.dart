import 'package:desafio_tecnico_getconnect/core/errors/chat_exceptions.dart';
import 'package:desafio_tecnico_getconnect/features/chat/domain/repositories/chat_repository_interface.dart';

class SendMessagesUsecase {
  final ChatRepositoryInterface repository;

  SendMessagesUsecase(this.repository);

  Future<void> call(String senderId, String senderName, String text) async{
    if(text.trim().isEmpty){
      throw BlankMessageException('Não é possível enviar uma mensagem vazia. ');

    }

    await repository.sendMessage(senderId, senderName, text.trim());

  }


}