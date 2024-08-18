import 'package:flutter/material.dart';

class EmptyDecks extends StatelessWidget {
  final Future<void> Function() _addDeck;

  const EmptyDecks({
    super.key,
    required Future<void> Function() addDeck,
  }) : _addDeck = addDeck;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/no_decks.png",
            height: 300,
          ),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              onPressed: _addDeck,
              child: const Text("Adicionar deck"),
            ),
          ),
        ],
      ),
    );
  }
}
