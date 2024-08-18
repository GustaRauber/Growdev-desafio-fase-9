import 'package:dio/dio.dart';
import 'package:fase_4/features/decks/dtos/add_question.dto.dart';
import 'package:fase_4/features/decks/views/add_question/add_question.store.dart';
import 'package:fase_4/shared/models/question.model.dart';
import 'package:fase_4/shared/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  final mockDio = MockDio();
  final addQuestion = AddQuestionDto(
    deckId: 1,
    ask: 'any_ask',
    answer: 'any_answer',
  );

  setUpAll(() {
    GetIt.I.registerSingleton<Dio>(mockDio);
  });

  tearDown(() {
    reset(mockDio);
    Constants.userToken = '';
  });

  tearDownAll(() {
    GetIt.I.unregister<Dio>();
  });
  group('AddQuestionStore Integration Test -', () {
    group('addNewQuestion -', () {
      test(
          'Deve add uma nova question com sucesso e popular os estados corretamente',
          () async {
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
        final sut = AddQuestionStore();

        expect(sut.isLoading, isFalse);
        expect(sut.error, isNull);

        final result = await sut.addNewQuestion(
          answer: addQuestion.answer,
          ask: addQuestion.ask,
          deckId: addQuestion.deckId,
        );

        expect(sut.isLoading, isFalse);
        expect(sut.error, isNull);
        expect(
          result,
          Question(
            id: 1,
            answer: addQuestion.answer,
            ask: addQuestion.ask,
          ),
        );
      });
      test(
        'Deve dar um erro ao adicionar uma question e popular os estados corretamente',
        () async {
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
          final sut = AddQuestionStore();

          expect(sut.isLoading, isFalse);
          expect(sut.error, isNull);

          final result = await sut.addNewQuestion(
            answer: addQuestion.answer,
            ask: addQuestion.ask,
            deckId: addQuestion.deckId,
          );

          expect(sut.isLoading, isFalse);
          expect(sut.error, 'any_error');
          expect(result, isNull);
        },
      );
    });
  });
}
