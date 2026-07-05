import 'package:desafio_tecnico_getconnect/core/errors/auth_exceptions.dart';
import 'package:desafio_tecnico_getconnect/core/routes/app_routes.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/entities/user_entity.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/usecase/login_usecase.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/usecase/logout_usecase.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/usecase/register_usecase.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class AuthController extends GetxController {
  final LoginUsecase loginUseCase;
  final RegisterUsecase registerUseCase;
  final LogoutUsecase logoutUseCase;
  final AuthRepositoryInterface authRepository;

  AuthController({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.authRepository

  });

  final Rx<UserEntity?> currentUser = Rx<UserEntity?>(null);

  final isLoading = false.obs;

  // Aqui utilizamos a Stream do Firestore para atualizar o usuario ativo automaticamente
  @override
  void onInit(){
    super.onInit();
    currentUser.bindStream(authRepository.authStateChanges);

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