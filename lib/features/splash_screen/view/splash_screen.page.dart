import 'package:flutter/material.dart';

import '../../authentication/views/login/login.page.dart';
import '../../decks/views/decks/decks.page.dart';
import 'splash.store.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final splashStore = SplashStore();

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final isAuthenticated = await splashStore.userIsAuthenticated();
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) {
            return isAuthenticated ? const DecksPage() : const LoginPage();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
