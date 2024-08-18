import 'package:fase_4/shared/views/modals/error.modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/utils/constants.dart';
import '../../../authentication/views/login/login.page.dart';
import '../new_deck/new_deck.page.dart';
import 'decks.store.dart';
import 'widgets/deck_list.widget.dart';
import 'widgets/empty_decks.widget.dart';

class DecksPage extends StatefulWidget {
  const DecksPage({super.key});

  @override
  State<DecksPage> createState() => _DecksPageState();
}

class _DecksPageState extends State<DecksPage> {
  final _store = DecksStore();

  Future<void> _navigateToNewDeck(BuildContext context) async {
    final deckTitle = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => const NewDeckPage(),
      ),
    );

    if (deckTitle == null) return;

    await _store.addDeck(deckTitle);

    if (!mounted) return;

    if (_store.error != null) {
      ErrorModal.show(context, _store.error!);
    }
  }

  @override
  void initState() {
    super.initState();
    GetIt.I.allReady().then((_) async {
      await _store.loadDecks();
      if (!mounted) return;
      if (_store.error != null) {
        ErrorModal.show(context, _store.error!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Decks"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final sharedPrefs = await SharedPreferences.getInstance();
              await sharedPrefs.clear();
              Constants.userToken = '';
              if (!mounted) return;
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const LoginPage()));
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Observer(
        builder: (_) {
          if (_store.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }

          return _store.decks.isEmpty
              ? EmptyDecks(addDeck: () => _navigateToNewDeck(context))
              : DeckList(store: _store);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToNewDeck(context),
        label: const Text("Adicionar"),
        backgroundColor: Colors.black,
      ),
    );
  }
}
