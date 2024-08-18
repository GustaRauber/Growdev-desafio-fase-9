// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_detail.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DeckDetailStore on DeckDetailStoreBase, Store {
  late final _$deckAtom =
      Atom(name: 'DeckDetailStoreBase.deck', context: context);

  @override
  Deck? get deck {
    _$deckAtom.reportRead();
    return super.deck;
  }

  @override
  set deck(Deck? value) {
    _$deckAtom.reportWrite(value, super.deck, () {
      super.deck = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'DeckDetailStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$addNewQuestionAsyncAction =
      AsyncAction('DeckDetailStoreBase.addNewQuestion', context: context);

  @override
  Future<void> addNewQuestion(Question question) {
    return _$addNewQuestionAsyncAction
        .run(() => super.addNewQuestion(question));
  }

  late final _$DeckDetailStoreBaseActionController =
      ActionController(name: 'DeckDetailStoreBase', context: context);

  @override
  void init(Deck deck) {
    final _$actionInfo = _$DeckDetailStoreBaseActionController.startAction(
        name: 'DeckDetailStoreBase.init');
    try {
      return super.init(deck);
    } finally {
      _$DeckDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
deck: ${deck},
isLoading: ${isLoading}
    ''';
  }
}
