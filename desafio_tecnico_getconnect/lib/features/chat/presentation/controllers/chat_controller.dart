import 'dart:async';
import 'package:desafio_tecnico_getconnect/core/errors/chat_exceptions.dart';
import 'package:desafio_tecnico_getconnect/features/auth/presentation/controllers/auth_controller.dart';
import 'package:desafio_tecnico_getconnect/features/chat/domain/entities/message_entity.dart';
import 'package:desafio_tecnico_getconnect/features/chat/domain/usecase/get_messages_usecase.dart';
import 'package:desafio_tecnico_getconnect/features/chat/domain/usecase/send_messages_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ChatController extends GetxController {
  final GetMessagesUseCase getMessagesUseCase;
  final SendMessagesUseCase sendMessagesUseCase;
  final AuthController authController;

  ChatController({
    required this.getMessagesUseCase,
    required this.sendMessagesUseCase,
    required this.authController,

  });

  final messages = <MessageEntity>[].obs;
  
  final messageText = ''.obs;
  final textController = TextEditingController();

  StreamSubscription<List<MessageEntity>>? _messagesSubscription;

  @override
  void onInit() {
    super.onInit();
    messages.bindStream(getMessagesUseCase());

    _messagesSubscription = getMessagesUseCase().listen(
    (newMessages) {
      messages.assignAll(newMessages);
    },
    onError: (_) {
      Get.snackbar('Atenção', 'Não foi possível carregar as mensagens.',
      );
    },
  );
    
  }

  Future<void> sendMessage() async {
    final text = messageText.value.trim();
    if (text.isEmpty) return;

    final currentUser = authController.currentUser.value;
    if (currentUser == null) {
      Get.snackbar('Erro', 'Você precisa estar logado para enviar mensagens.');
      return;
    }

    textController.clear();
    messageText.value = '';

    try {
      await sendMessagesUseCase(
        currentUser.id,
        currentUser.name,
        text,
      );
      
      textController.clear();
      messageText.value = '';
    } on ChatExceptions catch (e) {
      Get.snackbar('Atenção', e.message);
      
    } catch (e) {
      Get.snackbar('Erro', 'Ocorreu um erro inesperado ao enviar a mensagem.');

    }
  }

  @override
  void onClose() {
    _messagesSubscription?.cancel();
    textController.dispose();
    super.onClose();

  }

}