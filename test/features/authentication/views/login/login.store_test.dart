import 'package:dio/dio.dart';
import 'package:fase_4/features/authentication/views/login/login.store.dart';
import 'package:fase_4/shared/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockDio extends Mock implements Dio {}

void main() {
  final mockDio = MockDio();

  setUpAll(() {
    GetIt.I.registerSingleton<Dio>(mockDio);
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() {
    reset(mockDio);
    Constants.userToken = '';
    SharedPreferences.setMockInitialValues({});
  });

  tearDownAll(() {
    GetIt.I.unregister<Dio>();
  });

  group('Login Store Integration Test', () {
    group('login -', () {
      test(
        'Deve fazer o login e preencher e salvar o token no sharedpreference',
        () async {
          // dado (given)
          final sut = LoginStore();

          when(
            () => mockDio.post(
              '/login',
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
                data: 'any_token',
              ),
            ),
          );

          final sharedPrefs = await SharedPreferences.getInstance();
          expect(sut.error, isNull);
          expect(sut.isLoading, isFalse);
          expect(Constants.userToken, '');
          expect(sharedPrefs.getString('token_user'), isNull);

          // quando (when)
          final result = await sut.login('teste@teste.com', '123456');

          // então (then)
          expect(result, isTrue);

          expect(sut.error, isNull);
          expect(sut.isLoading, isFalse);
          expect(Constants.userToken, 'any_token');
          expect(sharedPrefs.getString('token_user'), 'any_token');
        },
      );

      test('Deve preencher o estado de error ao falhar a requisição', () async {
        // dado (given)
        final sut = LoginStore();

        when(
          () => mockDio.post(
            '/login',
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
                'error': 'any_error',
              },
            ),
          ),
        );

        final sharedPrefs = await SharedPreferences.getInstance();
        expect(sut.error, isNull);
        expect(sut.isLoading, isFalse);
        expect(Constants.userToken, '');
        expect(sharedPrefs.getString('token_user'), isNull);

        // quando (when)
        final result = await sut.login('teste@teste.com', '123456');

        // então (then)
        expect(result, isFalse);

        expect(sut.error, 'any_error');
        expect(sut.isLoading, isFalse);
        expect(Constants.userToken, '');
        expect(sharedPrefs.getString('token_user'), isNull);
      });
    });

    group('toggleShowPassword -', () {
      test('Deve inverter o valor do estado showPassword', () {
        final sut = LoginStore();
        expect(sut.showPassword, isFalse);
        sut.toggleShowPassword();
        expect(sut.showPassword, isTrue);
        sut.toggleShowPassword();
        expect(sut.showPassword, isFalse);
      });
    });
  });
}
