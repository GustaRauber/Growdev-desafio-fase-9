import 'package:fase_4/features/decks/dtos/add_question.dto.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/errors/custom_error.model.dart';
import '../../../../shared/models/question.model.dart';
import '../../services/question.service.dart';

part 'add_question.store.g.dart';

class AddQuestionStore = AddQuestionStoreBase with _$AddQuestionStore;

abstract class AddQuestionStoreBase with Store {
  final _questionService = QuestionService(GetIt.I.get());
  @observable
  bool isLoading = false;

  String? error;

  @action
  Future<Question?> addNewQuestion({
    required String ask,
    required String answer,
    required int deckId,
  }) async {
    try {
      error = null;
      isLoading = true;

      final addQuestionDto = AddQuestionDto(
        ask: ask,
        answer: answer,
        deckId: deckId,
      );

      final question = await _questionService.createQuestion(addQuestionDto);
      return question;
    } on CustomError catch (e) {
      error = e.message;
      return null;
    } finally {
      isLoading = false;
    }
  }
}
