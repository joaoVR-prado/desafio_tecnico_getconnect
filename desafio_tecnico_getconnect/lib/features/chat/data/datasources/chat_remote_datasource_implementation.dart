import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_tecnico_getconnect/core/errors/chat_exceptions.dart';
import 'package:desafio_tecnico_getconnect/features/chat/data/datasources/chat_remote_datasource.dart';

class ChatRemoteDatasourceImplementation implements ChatRemoteDatasourceInterface{
  final FirebaseFirestore firestore;

  ChatRemoteDatasourceImplementation(this.firestore);

  @override
  Stream<List<Map<String, dynamic>>> getMessages(){
    return firestore
      .collection('messages')
      .orderBy('timestamp', descending: false)
      .snapshots()
      .map((snapshot){
        return snapshot.docs.map((doc){
          final data = doc.data();
          data['id'] = doc.id;
          return data;
        }).toList();
      });
  }

  @override
  Future<void> sendMessage(Map<String, dynamic> messageMap) async{
    try{
      await firestore.collection('messages').add(messageMap);

    } catch (e){
      throw ServerChatException('Erro ao se conectar ao servidor: $e');

    }

  }

}