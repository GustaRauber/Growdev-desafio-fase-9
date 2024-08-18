import 'package:fase_4/shared/views/widgets/custom_input/custom_input.widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../shared/views/modals/error.modal.dart';
import '../../../decks/views/decks/decks.page.dart';
import '../register/register.page.dart';
import 'login.store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginStore = LoginStore();

  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Faça o Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomInput(
              label: 'E-mail',
              controller: emailController,
            ),
            const SizedBox(
              height: 15,
            ),
            Observer(builder: (context) {
              return CustomInput(
                controller: passController,
                label: 'Senha',
                isPassword: true,
                obscureText: loginStore.showPassword,
                onPressedSufixIcon: loginStore.toggleShowPassword,
              );
            }),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: 150,
              child: Observer(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: !loginStore.isLoading ? null : login,
                    child: loginStore.isLoading
                        ? const CircularProgressIndicator()
                        : const Text("Entrar"),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text.rich(
              TextSpan(
                text: "Não tem conta ainda? Toque ",
                children: [
                  TextSpan(
                    text: "aqui",
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const RegisterPage(),
                          ),
                        );
                      },
                  ),
                  const TextSpan(text: " para criar uma"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void login() async {
    final email = emailController.text;
    final password = passController.text;

    if (email.isEmpty || password.isEmpty) return;

    final result = await loginStore.login(email, password);

    if (!mounted) return;

    if (!result) {
      ErrorModal.show(context, loginStore.error!);
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const DecksPage(),
      ),
    );
  }
}
