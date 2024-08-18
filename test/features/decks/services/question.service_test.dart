import 'package:dio/dio.dart';
import 'package:fase_4/features/decks/dtos/add_question.dto.dart';
import 'package:fase_4/features/decks/services/question.service.dart';
import 'package:fase_4/shared/errors/custom_error.model.dart';
import 'package:fase_4/shared/models/question.model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  final mockDio = MockDio();
  final sut = QuestionService(mockDio);

  final addQuestion = AddQuestionDto(
    deckId: 1,
    ask: 'any_ask',
    answer: 'any_answer',
  );

  setUp(() => reset(mockDio));
  group('QuestionService Unit Test -', () {
    group('crateQuestion -', () {
      test('Deve criar a question na API e retornar os dados', () async {
        // dado
        when(
          () => mockDio.post(
            '/decks/${addQuestion.deckId}/questions',
            data: addQuestion.toMap(),
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              requestOptions: RequestOptions(),
              data: {
                'id': 1,
                'ask': 'any_ask',
                'answer': 'any_answer',
              },
              statusCode: 200,
            ),
          ),
        );

        // quando
        final result = await sut.createQuestion(addQuestion);

        // entao

        expect(
          result,
          Question(
            id: 1,
            ask: 'any_ask',
            answer: 'any_answer',
          ),
        );
      });

      test('Deve retornar um CustomError quando a requisição falhar', () async {
        // dado
        when(
          () => mockDio.post(
            '/decks/${addQuestion.deckId}/questions',
            data: addQuestion.toMap(),
            options: any(named: 'options'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              data: {
                'error': 'any_error',
              },
              statusCode: 500,
            ),
          ),
        );

        // quando
        final future = sut.createQuestion(addQuestion);

        // entao

        expect(
          future,
          throwsA(
            isA<CustomError>().having(
              (error) => error.message,
              'mensagem de erro',
              'any_error',
            ),
          ),
        );
      });
    });
  });
}
