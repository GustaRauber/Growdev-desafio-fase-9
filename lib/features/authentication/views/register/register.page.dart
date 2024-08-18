import 'package:fase_4/shared/views/widgets/custom_input/custom_input.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../shared/views/modals/error.modal.dart';
import 'register.store.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final registerStore = RegisterStore();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Faça o cadastro"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomInput(controller: emailController, label: 'E-mail'),
            const SizedBox(
              height: 15,
            ),
            Observer(builder: (context) {
              return CustomInput(
                controller: passwordController,
                label: 'Senha',
                isPassword: true,
                obscureText: !registerStore.showPassword,
                onPressedSufixIcon: registerStore.toggleShowPassword,
              );
            }),
            const SizedBox(
              height: 15,
            ),
            Observer(builder: (context) {
              return CustomInput(
                controller: confirmPasswordController,
                label: 'Confirmar senha',
                isPassword: true,
                obscureText: !registerStore.showPassword,
                onPressedSufixIcon: registerStore.toggleShowPassword,
              );
            }),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 40,
              width: 150,
              child: Observer(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: registerStore.isLoading ? null : createAccount,
                    child: registerStore.isLoading
                        ? const CircularProgressIndicator()
                        : const Text("Criar conta"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createAccount() async {
    final email = emailController.text;
    final pass = passwordController.text;
    final confirmPass = confirmPasswordController.text;
    if (email.isEmpty || pass.isEmpty || confirmPass.isEmpty) return;

    if (pass != confirmPass) {
      ErrorModal.show(context, 'Senha e confirmar senha são diferentes');
      return;
    }

    final result = await registerStore.createAccount(email, pass);

    if (!mounted) return;

    if (!result) {
      ErrorModal.show(context, registerStore.error!);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Conta criada com sucesso"),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
      ),
    );
    Navigator.of(context).pop();
  }
}
