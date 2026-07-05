import 'dart:async';
import 'package:desafio_tecnico_getconnect/features/auth/presentation/controllers/auth_controller.dart';
import 'package:desafio_tecnico_getconnect/features/chat/domain/entities/online_user_entity.dart';
import 'package:desafio_tecnico_getconnect/features/chat/domain/usecase/get_online_users_usecase.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OnlineUsersController extends GetxController {
  final GetOnlineUsersUsecase getOnlineUsersUsecase;
  final onlineUsers = <OnlineUserEntity>[].obs;
  
  StreamSubscription? _usersSubscription;
  OnlineUsersController(this.getOnlineUsersUsecase);

  String get currentUserId {
    return Get.find<AuthController>().currentUserId; 
    
  }

  @override
  void onInit() {
    super.onInit();
    _usersSubscription = getOnlineUsersUsecase().listen((users) {
      onlineUsers.assignAll(users);

    });
  }

  @override
  void onClose() {
    _usersSubscription?.cancel();
    super.onClose();

  }
}