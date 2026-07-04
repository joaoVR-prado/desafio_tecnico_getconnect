import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_tecnico_getconnect/features/auth/presentation/controllers/auth_controller.dart';
import 'package:desafio_tecnico_getconnect/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:desafio_tecnico_getconnect/features/chat/data/datasources/chat_remote_datasource_implementation.dart';
import 'package:desafio_tecnico_getconnect/features/chat/domain/repositories/chat_repository_implementation.dart';
import 'package:desafio_tecnico_getconnect/features/chat/domain/repositories/chat_repository_interface.dart';
import 'package:desafio_tecnico_getconnect/features/chat/domain/usecase/get_messages_usecase.dart';
import 'package:desafio_tecnico_getconnect/features/chat/domain/usecase/send_messages_usecase.dart';
import 'package:desafio_tecnico_getconnect/features/chat/presentation/controllers/chat_controller.dart';
import 'package:get/instance_manager.dart';

class ChatBinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut(() => FirebaseFirestore.instance);

    Get.lazyPut<ChatRemoteDatasourceInterface>(() => ChatRemoteDatasourceImplementation(Get.find()));

    Get.lazyPut<ChatRepositoryInterface>(() => ChatRepositoryImplementation(Get.find()));

    Get.lazyPut(() => GetMessagesUseCase(Get.find()));
    Get.lazyPut(() => SendMessagesUseCase(Get.find()));

    Get.lazyPut(() => ChatController(
      getMessagesUseCase: Get.find(),
      sendMessagesUseCase: Get.find(),
      authController: Get.find<AuthController>()

    ));



  }



}