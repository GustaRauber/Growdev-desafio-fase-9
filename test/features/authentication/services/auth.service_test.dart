import 'package:dio/dio.dart';
import 'package:fase_4/features/authentication/dtos/auth.dto.dart';
import 'package:fase_4/features/authentication/services/auth.service.dart';
import 'package:fase_4/shared/errors/custom_error.model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  final mockDio = MockDio();
  final sut = AuthService(mockDio);
  final authDto = AuthDto(
    email: 'teste@teste.com',
    pass: '123456',
  );

  setUp(() => reset(mockDio));
  group('AuthService Unit Test -', () {
    group("createAccount -", () {
      test('Deve fazer a requisição com sucesso e validar a chamada do dio',
          () async {
        //Dado (Given)
        when(
          () => mockDio.post(
            '/register',
            data: authDto.toMap(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              requestOptions: RequestOptions(),
            ),
          ),
        );

        // Quando (When)
        final result = await sut.createAccount(authDto);
        // Então (Then)
        expect(result, isTrue);
      });

      test('Deve ocorrer a exceção e retornar um CustomError', () async {
        // Dado (Given)
        final mockDio = MockDio();
        final sut = AuthService(mockDio);

        final authDto = AuthDto(
          email: 'teste@teste.com',
          pass: '123456',
        );

        when(
          () => mockDio.post(
            '/register',
            data: authDto.toMap(),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              data: {
                'error': 'any error',
              },
            ),
          ),
        );

        // Quando (When)

        final future = sut.createAccount(authDto);

        // Então (Then)
        expect(
          future,
          throwsA(
            isA<CustomError>().having(
              (error) => error.message,
              'valida prop message',
              'any error',
            ),
          ),
        );
      });
    });

    group("login -", () {
      test('Deve retornar o token do usuario ao fazer login', () async {
        // Dado (given)

        when(() => mockDio.post(
              '/login',
              data: authDto.toMap(),
            )).thenAnswer(
          (_) => Future.value(
            Response(
                requestOptions: RequestOptions(),
                statusCode: 200,
                data: 'any_token'),
          ),
        );
        // Quando (When)
        final result = await sut.login(authDto);

        // Então (Then)
        expect(result, equals('any_token'));
      });
      test('Deve retornar um CustomError ao falhar a requisição', () async {
        when(
          () => mockDio.post(
            '/login',
            data: authDto.toMap(),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              data: {
                'error': 'any error',
              },
            ),
          ),
        );
        // Quando (When)
        final future = sut.login(authDto);

        // Então (Then)
        expect(
          future,
          throwsA(
            isA<CustomError>().having(
              (error) => error.message,
              'valida prop message',
              'any error',
            ),
          ),
        );
      });
    });
  });
}
