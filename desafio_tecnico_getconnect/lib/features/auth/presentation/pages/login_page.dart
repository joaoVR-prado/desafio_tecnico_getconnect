import 'package:desafio_tecnico_getconnect/core/routes/app_routes.dart';
import 'package:desafio_tecnico_getconnect/features/auth/presentation/controllers/auth_controller.dart';
import 'package:desafio_tecnico_getconnect/features/auth/presentation/widgets/auth_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class LoginPage extends GetView<AuthController>{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() => AuthFormWidget(
                isLogin: true, 
                isLoading: controller.isLoading.value, 
                emailController: emailController, 
                passwordController: passwordController, 
                onSubmit: (){
                  controller.login(
                    emailController.text.trim(), 
                    passwordController.text.trim()
                  );
                }
              )),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.register), 
                child: const Text(
                  'Não tem cadastro? Crie agora!'
                )
              )
            ],
          ),
        ),
      ),

    );
  }

}