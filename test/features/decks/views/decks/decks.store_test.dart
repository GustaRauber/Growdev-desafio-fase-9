import 'package:dio/dio.dart';
import 'package:fase_4/features/decks/views/decks/decks.store.dart';
import 'package:fase_4/shared/models/deck.model.dart';
import 'package:fase_4/shared/models/question.model.dart';
import 'package:fase_4/shared/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  final mockDio = MockDio();

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
  group('DecksStore Integration Test -', () {
    group('loadDecks -', () {
      test('Deve buscar a lista de decks e popular os estados corretamente',
          () async {
        when(() => mockDio.get(
              '/decks',
              options: any(named: 'options'),
            )).thenAnswer(
          (_) => Future.value(
            Response(
              requestOptions: RequestOptions(),
              data: [
                {
                  'id': 1,
                  'name': 'any_title',
                  'questions': [],
                },
                {
                  'id': 2,
                  'name': 'any_title_2',
                  'questions': [
                    {
                      'id': 1,
                      'ask': "any_ask",
                      "answer": "any_answer",
                    }
                  ],
                }
              ],
              statusCode: 200,
            ),
          ),
        );
        final sut = DecksStore();

        expect(sut.isLoading, isFalse);
        expect(sut.error, isNull);
        expect(sut.decks, isEmpty);

        await sut.loadDecks();

        expect(sut.isLoading, isFalse);
        expect(sut.error, isNull);
        expect(sut.decks, [
          Deck(id: 1, name: 'any_title'),
          Deck(
            id: 2,
            name: 'any_title_2',
            questions: [
              Question(
                id: 1,
                ask: 'any_ask',
                answer: 'any_answer',
              ),
            ],
          ),
        ]);
      });
      test(
        'Deve buscar a lista de decks com sucesso e popular os estados corretamente',
        () async {
          when(() => mockDio.get(
                '/decks',
                options: any(named: 'options'),
              )).thenThrow(
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
          final sut = DecksStore();

          expect(sut.isLoading, isFalse);
          expect(sut.error, isNull);
          expect(sut.decks, isEmpty);

          await sut.loadDecks();

          expect(sut.isLoading, isFalse);
          expect(sut.error, 'any_error');
          expect(sut.decks, isEmpty);
        },
      );
    });

    group('addDeck -', () {
      test('Deve add um deck com sucesso e popular os estados corretamente',
          () async {
        when(
          () => mockDio.post(
            '/decks',
            data: {
              'name': 'any_title',
            },
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              requestOptions: RequestOptions(),
              data: {
                'id': 1,
                'name': 'any_title',
                'questions': [],
              },
              statusCode: 200,
            ),
          ),
        );
        final sut = DecksStore();

        expect(sut.isLoading, isFalse);
        expect(sut.error, isNull);
        expect(sut.decks, isEmpty);

        await sut.addDeck('any_title');

        expect(sut.isLoading, isFalse);
        expect(sut.error, isNull);
        expect(sut.decks, [Deck(id: 1, name: 'any_title')]);
      });
      test(
        'Deve dar um erro ao adicionar um deck e popular os estados corretamente',
        () async {
          when(
            () => mockDio.post('/decks',
                data: {
                  'name': 'any_title',
                },
                options: any(named: 'options')),
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
          final sut = DecksStore();

          expect(sut.isLoading, isFalse);
          expect(sut.error, isNull);
          expect(sut.decks, isEmpty);

          await sut.addDeck('any_title');

          expect(sut.isLoading, isFalse);
          expect(sut.error, 'any_error');
          expect(sut.decks, isEmpty);
        },
      );
    });

    group('removeDeck -', () {
      test('Deve remover um deck com sucesso e popular os estados corretamente',
          () async {
        final sut = DecksStore();

        expect(sut.isLoading, isFalse);
        expect(sut.error, isNull);
        expect(sut.decks, isEmpty);

        when(
          () => mockDio.post(
            '/decks',
            data: {
              'name': 'any_title',
            },
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              requestOptions: RequestOptions(),
              data: {
                'id': 1,
                'name': 'any_title',
                'questions': [],
              },
              statusCode: 200,
            ),
          ),
        );

        await sut.addDeck('any_title');

        when(
          () => mockDio.post(
            '/decks',
            data: {
              'name': 'any_title_2',
            },
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              requestOptions: RequestOptions(),
              data: {
                'id': 2,
                'name': 'any_title_2',
                'questions': [],
              },
              statusCode: 200,
            ),
          ),
        );
        await sut.addDeck('any_title_2');

        expect(sut.isLoading, isFalse);
        expect(sut.error, isNull);
        expect(sut.decks, [
          Deck(id: 1, name: 'any_title'),
          Deck(id: 2, name: 'any_title_2'),
        ]);

        when(
          () => mockDio.delete(
            '/decks/1',
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
            ),
          ),
        );

        await sut.removeDeck(1);

        expect(sut.isLoading, isFalse);
        expect(sut.error, isNull);
        expect(sut.decks, [Deck(id: 2, name: 'any_title_2')]);
      });
      test(
        'Deve dar um erro ao remover um deck e popular os estados corretamente',
        () async {
          when(
            () => mockDio.delete(
              '/decks/1',
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
          final sut = DecksStore();

          expect(sut.isLoading, isFalse);
          expect(sut.error, isNull);
          expect(sut.decks, isEmpty);

          await sut.removeDeck(1);

          expect(sut.isLoading, isFalse);
          expect(sut.error, 'any_error');
          expect(sut.decks, isEmpty);
        },
      );
    });
  });
}
