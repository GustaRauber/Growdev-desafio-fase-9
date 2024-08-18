import 'package:dio/dio.dart';

class Constants {
  static String userToken = '';
  static String baseUrl = '//insira aqui a chave api';

  static Options get dioOptions => Options(
        headers: {
          'authorization': 'Bearer $userToken',
        },
      );
}
