import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../shared/models/deck.model.dart';
import 'quiz.store.dart';
import 'widgets/content_quiz.widget.dart';
import 'widgets/result_quiz.widget.dart';

class QuizPage extends StatelessWidget {
  final Deck deck;
  final store = QuizStore();
  QuizPage({super.key, required this.deck}) {
    store.setDeck(deck);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Quiz: ${deck.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Observer(
          builder: ((context) {
            return store.isFinished
                ? ResultQuiz(score: store.score)
                : ContentQuiz(store: store);
          }),
        ),
      ),
    );
  }
}
