import 'package:flutter/material.dart';

class ErrorModal {
  static void show(BuildContext context, String error) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return AlertDialog(
          title: const Icon(Icons.warning_amber),
          content: Text(
            error,
            textAlign: TextAlign.center,
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Tentar novamente"),
              ),
            ),
          ],
        );
      },
    );
  }
}
