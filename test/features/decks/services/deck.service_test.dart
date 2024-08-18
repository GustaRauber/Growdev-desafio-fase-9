import 'package:dio/dio.dart';
import 'package:fase_4/features/decks/services/deck.service.dart';
import 'package:fase_4/shared/errors/custom_error.model.dart';
import 'package:fase_4/shared/models/deck.model.dart';
import 'package:fase_4/shared/models/question.model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  final mockDio = MockDio();
  final sut = DeckService(mockDio);

  setUp(() => reset(mockDio));
  group('DeckService Unit Test -', () {
    group('createDeck -', () {
      test('Deve criar o deck na API e retornar os dados', () async {
        // dado
        when(() => mockDio.post(
              '/decks',
              data: {
                'name': 'any_title',
              },
              options: any(named: 'options'),
            )).thenAnswer(
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

        // quando
        final result = await sut.createDeck('any_title');

        // entao

        expect(result, Deck(id: 1, name: 'any_title'));
      });

      test('Deve retornar um CustomError quando a requisição falhar', () async {
        // dado
        when(
          () => mockDio.post(
            '/decks',
            data: {
              'name': 'any_title',
            },
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
        final future = sut.createDeck('any_title');

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

    group('getDecks -', () {
      test('Deve buscar os decks na API e retornar uma lista com 2 elementos',
          () async {
        // dado
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

        // quando
        final result = await sut.getDecks();

        // entao

        expect(result, [
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

      test('Deve buscar os decks na API e retornar uma lista vazia', () async {
        // dado
        when(() => mockDio.get(
              '/decks',
              options: any(named: 'options'),
            )).thenAnswer(
          (_) => Future.value(
            Response(
              requestOptions: RequestOptions(),
              data: [],
              statusCode: 200,
            ),
          ),
        );

        // quando
        final result = await sut.getDecks();

        // entao

        expect(result, isEmpty);
      });
      test('Deve retornar um CustomError quando a requisição falhar', () async {
        // dado
        when(
          () => mockDio.get(
            '/decks',
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
        final future = sut.getDecks();

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

    group('remvoveDeck -', () {
      test('Deve remover o deck na API', () async {
        // dado
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

        // quando
        // entao
        expect(sut.removeDeck(1), isA<void>());
      });

      test('Deve retornar um CustomError quando a requisição falhar', () async {
        // dado
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

        // quando
        final future = sut.removeDeck(1);

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
