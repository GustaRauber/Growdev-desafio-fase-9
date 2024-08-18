import 'package:dio/dio.dart';

import '../../../shared/errors/custom_error.model.dart';
import '../../../shared/models/question.model.dart';
import '../../../shared/utils/constants.dart';
import '../dtos/add_question.dto.dart';

class QuestionService {
  final Dio _dio;
  QuestionService(this._dio);

  Future<Question> createQuestion(AddQuestionDto dto) async {
    try {
      final response = await _dio.post(
        '/decks/${dto.deckId}/questions',
        data: dto.toMap(),
        options: Constants.dioOptions,
      );

      return Question.fromMap(response.data);
    } on DioException catch (e) {
      throw CustomError(
        e.response!.data['error'],
      );
    }
  }
}
