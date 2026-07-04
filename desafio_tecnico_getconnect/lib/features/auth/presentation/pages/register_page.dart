import 'package:desafio_tecnico_getconnect/features/auth/presentation/controllers/auth_controller.dart';
import 'package:desafio_tecnico_getconnect/features/auth/presentation/widgets/auth_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class RegisterPage extends GetView<AuthController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Obx(() => AuthFormWidget(
            isLogin: false,
            nameController: nameController,
            emailController: emailController,
            passwordController: passwordController,
            confirmPasswordController: confirmPasswordController,
            isLoading: controller.isLoading.value,
            onSubmit: () {
              final password = passwordController.text.trim();
              final confirmPassword = confirmPasswordController.text.trim();
              if (password != confirmPassword) {
                Get.snackbar('Atenção', 'As senhas não coincidem.');
                return;
              }
              controller.register(
                nameController.text.trim(),
                emailController.text.trim(),
                password,
              );
            },
          )),
        ),
      ),
    );
  }

}