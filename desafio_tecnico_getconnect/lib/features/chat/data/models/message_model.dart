import 'package:desafio_tecnico_getconnect/features/chat/domain/entities/message_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.id,
    required super.senderId,
    required super.senderName,
    required super.text,
    required super.timestamp

  });

  factory MessageModel.fromMap(Map<String, dynamic> map, String documentId){
    return MessageModel(
      id: documentId, 
      senderId: map['senderId'] ?? '', 
      senderName: map['senderName'] ?? 'Desconhecido', 
      text: map['text'] ?? '', 
      timestamp: (map['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),

    );

  }

  Map<String, dynamic> toMap(){
    return {
      'senderId': senderId,
      'senderName': senderName,
      'text': text,
      'timestamp': FieldValue.serverTimestamp()

    };

  }


}