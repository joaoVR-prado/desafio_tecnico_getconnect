import 'package:desafio_tecnico_getconnect/core/routes/app_routes.dart';
import 'package:desafio_tecnico_getconnect/core/routes/auth_middleware.dart';
import 'package:desafio_tecnico_getconnect/features/auth/presentation/pages/login_page.dart';
import 'package:desafio_tecnico_getconnect/features/auth/presentation/pages/register_page.dart';
import 'package:desafio_tecnico_getconnect/features/chat/presentation/bindings/chat_binding.dart';
import 'package:desafio_tecnico_getconnect/features/chat/presentation/pages/chat_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login, 
      page: () => const LoginPage(),
      middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: AppRoutes.register, 
      page: () => const RegisterPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatPage(),
      binding: ChatBinding(),
      middlewares: [AuthMiddleware()],
    ),

  ];

}