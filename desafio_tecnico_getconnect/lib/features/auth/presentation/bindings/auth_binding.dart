import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_tecnico_getconnect/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:desafio_tecnico_getconnect/features/auth/data/datasources/auth_remote_datasource_implementation.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/repositories/auth_repository_implementation.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/usecase/login_usecase.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/usecase/logout_usecase.dart';
import 'package:desafio_tecnico_getconnect/features/auth/domain/usecase/register_usecase.dart';
import 'package:desafio_tecnico_getconnect/features/auth/presentation/controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies(){
    Get.lazyPut(() => FirebaseAuth.instance);
    Get.lazyPut(() => FirebaseFirestore.instance);

    Get.lazyPut<AuthRemoteDataSourceInterface>(() => AuthRemoteDatasourceImplementation(Get.find(), Get.find()));

    Get.lazyPut<AuthRepositoryInterface>(() => AuthRepositoryImplementation(Get.find()));

    Get.lazyPut(() => LoginUsecase(Get.find()));
    Get.lazyPut(() => RegisterUsecase(Get.find()));
    Get.lazyPut(() => LogoutUsecase(Get.find()));

    Get.put(AuthController(
      loginUseCase: Get.find(),
      registerUseCase: Get.find(),
      logoutUseCase: Get.find(),
      authRepository: Get.find(),
      updateOnlineStatusUsecase: Get.find()

    ), permanent: true);

  }

}