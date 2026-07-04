import 'package:desafio_tecnico_getconnect/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:desafio_tecnico_getconnect/features/chat/data/models/message_model.dart';
import 'package:desafio_tecnico_getconnect/features/chat/domain/entities/message_entity.dart';
import 'package:desafio_tecnico_getconnect/features/chat/domain/repositories/chat_repository_interface.dart';

class ChatRepositoryImplementation implements ChatRepositoryInterface {
  final ChatRemoteDatasourceInterface remoteDataSource;

  ChatRepositoryImplementation(this.remoteDataSource);

  @override
  Stream<List<MessageEntity>> getMessages(){
    return remoteDataSource.getMessages().map((listOfMaps){
      return listOfMaps.map((map){
        final id = map['id'] as String;
        return MessageModel.fromMap(map, id);

      }).toList();
    });
  }

  @override
  Future<void> sendMessage(String senderId, String senderName, String text) async{
    final messageModel = MessageModel(
      id: '', 
      senderId: senderId, 
      senderName: senderName, 
      text: text, 
      timestamp: DateTime.now()

    );
    await remoteDataSource.sendMessage(messageModel.toMap());
    
  }

}