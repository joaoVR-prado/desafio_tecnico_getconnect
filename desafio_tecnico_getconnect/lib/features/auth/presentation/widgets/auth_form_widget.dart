import 'package:flutter/material.dart';

class AuthFormWidget extends StatelessWidget {
  final bool isLogin;
  final bool isLoading;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? nameController;
  final TextEditingController? confirmPasswordController;
  final VoidCallback onSubmit;

  const AuthFormWidget({
    super.key,
    required this.isLogin,
    required this.isLoading,
    required this.emailController,
    required this.passwordController,
    this.nameController,
    this.confirmPasswordController,
    required this.onSubmit

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if(!isLogin && nameController != null) ...[
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Nome'
            ),
            keyboardType: TextInputType.name,

          ),
          const SizedBox(height: 16),

        ],
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'E-mail'
          ),
          keyboardType: TextInputType.emailAddress,

        ),
        const SizedBox(height: 16),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(
            labelText: 'Senha'
          ),
          obscureText: true,
        ),

        // Não estava explicito o uso do campo "Confirmar Senha" na documentação, 
        // mas decidi incluir para uma melhor experiência de usuário
        if(!isLogin && confirmPasswordController != null) ...[
          const SizedBox(height: 16),
          TextField(
            controller: confirmPasswordController,
            decoration: const InputDecoration(
              labelText: 'Confirmar Senha'
            ),
            obscureText: true,
          )
        ],

        const SizedBox(height: 24),
        if(isLoading)
          const Center(
            child: CircularProgressIndicator(),
          )
        else
          ElevatedButton(
            onPressed: onSubmit, 
            child: Text(
              isLogin ? 'Entrar' : 'Cadastrar'

            )
          ),
      ],
    );
    
  }

}