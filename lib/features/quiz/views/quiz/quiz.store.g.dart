// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$QuizStore on QuizStoreBase, Store {
  late final _$currentQuestionAtom =
      Atom(name: 'QuizStoreBase.currentQuestion', context: context);

  @override
  int get currentQuestion {
    _$currentQuestionAtom.reportRead();
    return super.currentQuestion;
  }

  @override
  set currentQuestion(int value) {
    _$currentQuestionAtom.reportWrite(value, super.currentQuestion, () {
      super.currentQuestion = value;
    });
  }

  late final _$showAskAtom =
      Atom(name: 'QuizStoreBase.showAsk', context: context);

  @override
  bool get showAsk {
    _$showAskAtom.reportRead();
    return super.showAsk;
  }

  @override
  set showAsk(bool value) {
    _$showAskAtom.reportWrite(value, super.showAsk, () {
      super.showAsk = value;
    });
  }

  late final _$isFinishedAtom =
      Atom(name: 'QuizStoreBase.isFinished', context: context);

  @override
  bool get isFinished {
    _$isFinishedAtom.reportRead();
    return super.isFinished;
  }

  @override
  set isFinished(bool value) {
    _$isFinishedAtom.reportWrite(value, super.isFinished, () {
      super.isFinished = value;
    });
  }

  late final _$QuizStoreBaseActionController =
      ActionController(name: 'QuizStoreBase', context: context);

  @override
  void alterAskAndAnswer() {
    final _$actionInfo = _$QuizStoreBaseActionController.startAction(
        name: 'QuizStoreBase.alterAskAndAnswer');
    try {
      return super.alterAskAndAnswer();
    } finally {
      _$QuizStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void nextQuestion(bool isCorrect) {
    final _$actionInfo = _$QuizStoreBaseActionController.startAction(
        name: 'QuizStoreBase.nextQuestion');
    try {
      return super.nextQuestion(isCorrect);
    } finally {
      _$QuizStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentQuestion: ${currentQuestion},
showAsk: ${showAsk},
isFinished: ${isFinished}
    ''';
  }
}
