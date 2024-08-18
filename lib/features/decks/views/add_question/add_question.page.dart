import 'package:fase_4/shared/views/modals/error.modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../shared/views/widgets/custom_input/custom_input.widget.dart';
import 'add_question.store.dart';

class AddQuestionPage extends StatefulWidget {
  final int deckId;
  const AddQuestionPage({super.key, required this.deckId});

  @override
  State<AddQuestionPage> createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final _askController = TextEditingController();
  final _answerController = TextEditingController();
  final _store = AddQuestionStore();

  @override
  void dispose() {
    _askController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  Future<void> _addQuestion() async {
    final ask = _askController.text;
    final answer = _answerController.text;

    if (ask.isEmpty || answer.isEmpty) return;
    final question = await _store.addNewQuestion(
      ask: ask,
      answer: answer,
      deckId: widget.deckId,
    );

    if (!mounted) return;

    if (_store.error != null) {
      ErrorModal.show(context, _store.error!);
      return;
    }

    Navigator.of(context).pop(question);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo cartão"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomInput(
              controller: _askController,
              label: "Pergunta",
            ),
            const SizedBox(
              height: 50,
            ),
            CustomInput(
              controller: _answerController,
              label: "Resposta",
              maxLines: 3,
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 50,
              width: 150,
              child: Observer(
                builder: (context) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: _store.isLoading ? null : _addQuestion,
                    child: _store.isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : const Text("Adicionar"),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
