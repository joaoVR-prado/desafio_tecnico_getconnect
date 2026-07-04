import 'package:desafio_tecnico_getconnect/core/routes/app_routes.dart';
import 'package:desafio_tecnico_getconnect/features/auth/presentation/bindings/auth_binding.dart';
import 'package:desafio_tecnico_getconnect/features/auth/presentation/pages/login_page.dart';
import 'package:desafio_tecnico_getconnect/features/auth/presentation/pages/register_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login, 
      page: () => const LoginPage(),
      binding: AuthBinding()
    ),
    GetPage(
      name: AppRoutes.register, 
      page: () => const RegisterPage()
    )

    // TODO: Rota do chat

  ];

}