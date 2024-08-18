import 'package:fase_4/features/quiz/views/quiz/quiz.store.dart';
import 'package:fase_4/shared/models/deck.model.dart';
import 'package:fase_4/shared/models/question.model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final deckWithOneQuestion = Deck(
    id: 1,
    name: 'any_deck',
    questions: [
      Question(id: 1, ask: 'any_ask', answer: 'any_answer'),
    ],
  );
  final deckWithTwoQuestion = Deck(
    id: 1,
    name: 'any_deck',
    questions: [
      Question(id: 1, ask: 'any_ask', answer: 'any_answer'),
      Question(id: 2, ask: 'any_ask_2', answer: 'any_answer_2'),
    ],
  );
  group('QuizStore Unit Test -', () {
    test(
      'Deve definir uma deck e alternar entre resposta e pergunta ',
      () {
        final sut = QuizStore();

        expect(sut.deck, isNull);
        expect(sut.score, 0);
        expect(sut.isFinished, isFalse);
        expect(sut.currentQuestion, 0);
        expect(sut.showAsk, isTrue);

        sut.setDeck(deckWithOneQuestion);

        expect(sut.deck, deckWithOneQuestion);

        sut.alterAskAndAnswer();
        expect(sut.showAsk, isFalse);

        sut.alterAskAndAnswer();
        expect(sut.showAsk, isTrue);
      },
    );
    test('Deve avançar e finalizar o quizz com 1 acerto e 1 question -', () {
      final sut = QuizStore();
      sut.setDeck(deckWithOneQuestion);

      expect(sut.score, 0);
      expect(sut.currentQuestion, 0);
      expect(sut.isFinished, isFalse);

      sut.nextQuestion(true);
      expect(sut.score, 1);
      expect(sut.currentQuestion, 0);
      expect(sut.isFinished, isTrue);
    });

    test('Deve avançar e finalizar o quizz com 0 acerto e 1 question -', () {
      final sut = QuizStore();
      sut.setDeck(deckWithOneQuestion);

      expect(sut.score, 0);
      expect(sut.currentQuestion, 0);
      expect(sut.isFinished, isFalse);

      sut.nextQuestion(false);
      expect(sut.score, 0);
      expect(sut.currentQuestion, 0);
      expect(sut.isFinished, isTrue);
    });

    test('Deve avançar e finalizar o quizz com 2 acerto e 2 question -', () {
      final sut = QuizStore();
      sut.setDeck(deckWithTwoQuestion);

      expect(sut.score, 0);
      expect(sut.currentQuestion, 0);
      expect(sut.isFinished, isFalse);

      sut.nextQuestion(true);

      expect(sut.score, 1);
      expect(sut.currentQuestion, 1);
      expect(sut.isFinished, isFalse);

      sut.nextQuestion(true);

      expect(sut.score, 2);
      expect(sut.currentQuestion, 1);
      expect(sut.isFinished, isTrue);
    });
  });
}
