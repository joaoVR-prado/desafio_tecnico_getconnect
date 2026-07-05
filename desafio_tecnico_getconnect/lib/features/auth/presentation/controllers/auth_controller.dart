import 'package:desafio_tecnico_getconnect/core/errors/auth_exceptions.dart';
import 'package:desafio_tecnico_getconnect/core/routes/app_routes.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/entities/user_entity.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/usecase/login_usecase.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/usecase/logout_usecase.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/usecase/register_usecase.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/usecase/update_online_status_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class AuthController extends GetxController with WidgetsBindingObserver {
  final LoginUsecase loginUseCase;
  final RegisterUsecase registerUseCase;
  final LogoutUsecase logoutUseCase;
  final AuthRepositoryInterface authRepository;
  final UpdateOnlineStatusUsecase updateOnlineStatusUsecase;

  AuthController({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.authRepository,
    required this.updateOnlineStatusUsecase

  });

  final Rx<UserEntity?> currentUser = Rx<UserEntity?>(null);
  final isLoading = false.obs;

  @override
  void onInit(){
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    currentUser.bindStream(authRepository.authStateChanges);

  }

  @override
  void onClose(){
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();

  }

  @override
  void didChangeAppLifeCycle(AppLifecycleState state){
    final user = currentUser.value;
    if(user == null) return;

    if(state == AppLifecycleState.resumed){
      updateOnlineStatusUsecase(user.id, true);

    } else if(state == AppLifecycleState.paused || state == AppLifecycleState.detached){
      updateOnlineStatusUsecase(user.id, false);

    }

  }

  Future<void> login(String email, String password) async{
    try{
      isLoading.value = true;
      await loginUseCase(email, password);
      Get.offAllNamed(AppRoutes.chat);

    } on AuthExceptions catch (e){
      Get.snackbar('Atenção', e.message);

    } finally{
      isLoading.value = false;

    }

  }

  Future<void> register(String name, String email, String password) async{
    try{
      isLoading.value = true;
      await registerUseCase(name, email, password);
      if (currentUser.value != null) {
        currentUser.value = UserEntity(
          id: currentUser.value!.id,
          name: name,
          email: currentUser.value!.email,
        );
      }
      Get.offAllNamed(AppRoutes.chat);

    } on AuthExceptions catch(e){
      Get.snackbar('Atenção', e.message);

    } finally{
      isLoading.value = false;

    }

  }

  Future<void> logout() async{
    await logoutUseCase();

  }

}