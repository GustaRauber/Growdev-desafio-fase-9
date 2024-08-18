import 'package:dio/dio.dart';
import 'package:fase_4/features/authentication/views/register/register.store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  final mockDio = MockDio();

  setUpAll(() {
    GetIt.I.registerSingleton<Dio>(mockDio);
  });

  tearDown(() => reset(mockDio));

  tearDownAll(() {
    GetIt.I.unregister<Dio>();
  });

  group('Register Store Integration Test', () {
    group('createAccount -', () {
      test('Deve criar a conta e retornar true', () async {
        //dado (given)
        final sut = RegisterStore();

        when(
          () => mockDio.post(
            '/register',
            data: {
              'email': 'teste@teste.com',
              'password': '123456',
            },
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
            ),
          ),
        );

        expect(sut.error, isNull);
        expect(sut.isLoading, isFalse);

        //quando (when)

        final result = await sut.createAccount('teste@teste.com', '123456');

        //entao (then)
        expect(result, isTrue);
        expect(sut.error, isNull);
        expect(sut.isLoading, isFalse);
      });

      test('Deve preencher o estado de error ao falhar a requisição', () async {
        //dado (given)
        final sut = RegisterStore();

        when(
          () => mockDio.post(
            '/register',
            data: {
              'email': 'teste@teste.com',
              'password': '123456',
            },
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

        expect(sut.error, isNull);
        expect(sut.isLoading, isFalse);

        //quando (when)

        final result = await sut.createAccount('teste@teste.com', '123456');

        //entao (then)
        expect(result, isFalse);

        expect(sut.error, 'any error');
        expect(sut.isLoading, isFalse);
      });
    });
    group('toggleShowPassword -', () {
      test('Deve inverter o valor do estado showPassword', () {
        final sut = RegisterStore();
        expect(sut.showPassword, isFalse);
        sut.toggleShowPassword();
        expect(sut.showPassword, isTrue);
        sut.toggleShowPassword();
        expect(sut.showPassword, isFalse);
      });
    });
  });
}
