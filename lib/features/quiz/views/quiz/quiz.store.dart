import 'package:mobx/mobx.dart';

import '../../../../shared/models/deck.model.dart';

part 'quiz.store.g.dart';

class QuizStore = QuizStoreBase with _$QuizStore;

abstract class QuizStoreBase with Store {
  @observable
  int currentQuestion = 0;

  @observable
  bool showAsk = true;

  int score = 0;

  @observable
  bool isFinished = false;

  Deck? deck;

  void setDeck(Deck deck) => this.deck = deck;

  @action
  void alterAskAndAnswer() => showAsk = !showAsk;

  @action
  void nextQuestion(bool isCorrect) {
    if (isCorrect) score++;

    if ((currentQuestion + 1) == deck!.questions.length) {
      isFinished = true;
    } else {
      currentQuestion++;
      showAsk = true;
    }
  }
}
