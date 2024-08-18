import 'package:mobx/mobx.dart';

import '../../../../shared/models/deck.model.dart';
import '../../../../shared/models/question.model.dart';

part 'deck_detail.store.g.dart';

class DeckDetailStore = DeckDetailStoreBase with _$DeckDetailStore;

abstract class DeckDetailStoreBase with Store {
  @observable
  Deck? deck;

  @action
  void init(Deck deck) {
    this.deck = deck;
  }

  @observable
  bool isLoading = false;

  @action
  Future<void> addNewQuestion(Question question) async {
    final tempQuestions = List<Question>.from(deck!.questions);
    tempQuestions.add(question);
    deck = deck!.copyWith(questions: tempQuestions);
  }
}
