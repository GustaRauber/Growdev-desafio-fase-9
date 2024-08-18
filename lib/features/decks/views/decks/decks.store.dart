import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/errors/custom_error.model.dart';
import '../../../../shared/models/deck.model.dart';
import '../../services/deck.service.dart';

part 'decks.store.g.dart';

class DecksStore = DecksStoreBase with _$DecksStore;

abstract class DecksStoreBase with Store {
  final _deckService = DeckService(GetIt.I.get());

  @observable
  ObservableList<Deck> decks = <Deck>[].asObservable();

  @observable
  bool isLoading = false;
  String? error;

  @action
  Future<void> loadDecks() async {
    try {
      error = null;
      isLoading = true;

      final allDecks = await _deckService.getDecks();

      decks = allDecks.asObservable();
    } on CustomError catch (e) {
      error = e.message;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> addDeck(String deckTitle) async {
    try {
      error = null;
      isLoading = true;
      final deck = await _deckService.createDeck(deckTitle);
      decks.add(deck);
    } on CustomError catch (e) {
      error = e.message;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> removeDeck(int deckId) async {
    try {
      error = null;

      await _deckService.removeDeck(deckId);

      decks.removeWhere((deck) => deck.id == deckId);
    } on CustomError catch (e) {
      error = e.message;
    }
  }
}
