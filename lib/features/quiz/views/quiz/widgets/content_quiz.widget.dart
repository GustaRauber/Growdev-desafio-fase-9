import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../quiz.store.dart';
import 'quiz_answer_button.widget.dart';

class ContentQuiz extends StatelessWidget {
  final QuizStore store;

  const ContentQuiz({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Observer(
              builder: (context) {
                return Text(
                  "${store.currentQuestion + 1} / ${store.deck!.questions.length}",
                  style: const TextStyle(
                    fontSize: 26,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Observer(
                  builder: (context) {
                    return Text(
                      store.showAsk
                          ? store.deck!.questions[store.currentQuestion].ask
                          : store.deck!.questions[store.currentQuestion].answer,
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  onPressed: store.alterAskAndAnswer,
                  child: Observer(builder: (context) {
                    return Text(
                        "Visualizar ${store.showAsk ? 'resposta' : 'pergunta'}");
                  }),
                ),
                const SizedBox(
                  height: 100,
                ),
                QuizAnswerButton(
                  label: "Acertei :)",
                  color: Colors.green,
                  onPressed: () => store.nextQuestion(true),
                ),
                const SizedBox(
                  height: 20,
                ),
                QuizAnswerButton(
                  label: "Errei :(",
                  color: Colors.red,
                  onPressed: () => store.nextQuestion(false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
