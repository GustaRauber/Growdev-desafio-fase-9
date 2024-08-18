import 'package:dio/dio.dart';

import '../../../shared/errors/custom_error.model.dart';

import '../dtos/auth.dto.dart';

class AuthService {
  late final Dio _dio;

  AuthService(Dio dio) : _dio = dio;

  Future<bool> createAccount(AuthDto auth) async {
    try {
      await _dio.post(
        '/register',
        data: auth.toMap(),
      );

      return true;
    } on DioException catch (e) {
      throw CustomError(e.response!.data['error']);
    }
  }

  Future<String> login(AuthDto auth) async {
    try {
      final result = await _dio.post(
        '/login',
        data: auth.toMap(),
      );
      return result.data;
    } on DioException catch (e) {
      throw CustomError(e.response!.data['error']);
    }
  }
}
