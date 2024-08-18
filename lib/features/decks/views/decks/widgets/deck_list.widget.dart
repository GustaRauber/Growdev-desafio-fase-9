import 'package:fase_4/shared/views/modals/error.modal.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/models/deck.model.dart';
import '../../deck_detail/deck_detail.page.dart';
import '../decks.store.dart';

class DeckList extends StatefulWidget {
  final DecksStore _store;

  const DeckList({
    super.key,
    required DecksStore store,
  }) : _store = store;

  @override
  State<DeckList> createState() => _DeckListState();
}

class _DeckListState extends State<DeckList> {
  Future<void> _navigateToDeckDetail({
    required BuildContext context,
    required Deck deck,
  }) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DeckDetailPage(deck: deck),
      ),
    );

    await widget._store.loadDecks();

    if (!mounted) return;
    if (widget._store.error != null) {
      ErrorModal.show(context, widget._store.error!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget._store.decks.length,
      itemBuilder: (_, index) {
        final deck = widget._store.decks[index];
        return InkWell(
          onTap: () => _navigateToDeckDetail(
            context: context,
            deck: deck,
          ),
          onLongPress: () => removeDeck(deck),
          child: Container(
            height: 150,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  deck.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${deck.questions.length} ${deck.questions.length == 1 ? 'cartão' : 'cartões'}",
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> removeDeck(Deck deck) async {
    await widget._store.removeDeck(deck.id);

    if (!mounted) return;

    if (widget._store.error != null) {
      ErrorModal.show(context, widget._store.error!);
    }
  }
}
