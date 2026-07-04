import 'package:desafio_tecnico_getconnect/features/chat/domain/entities/message_entity.dart';
import 'package:desafio_tecnico_getconnect/features/chat/domain/repositories/chat_repository_interface.dart';

class GetMessagesUseCase {
  final ChatRepositoryInterface repository;

  GetMessagesUseCase(this.repository);

  Stream<List<MessageEntity>> call(){
    return repository.getMessages();

  }

}