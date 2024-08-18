import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../shared/models/deck.model.dart';
import 'deck_detail.store.dart';
import 'widgets/add_question_button.widget.dart';
import 'widgets/start_quiz_button.widget.dart';

class DeckDetailPage extends StatelessWidget {
  final _store = DeckDetailStore();

  DeckDetailPage({
    super.key,
    required Deck deck,
  }) {
    _store.init(deck);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(_store.deck!.name),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _store.deck!.name,
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Observer(
                    builder: (context) {
                      return Text(
                        "${_store.deck!.questions.length} ${_store.deck!.questions.length == 1 ? 'cartão' : 'cartões'}",
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  AddQuestionButton(store: _store),
                  const SizedBox(height: 20),
                  StartQuizButton(store: _store)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
