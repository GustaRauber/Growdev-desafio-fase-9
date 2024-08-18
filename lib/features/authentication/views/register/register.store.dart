import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/errors/custom_error.model.dart';
import '../../dtos/auth.dto.dart';
import '../../services/auth.service.dart';

part 'register.store.g.dart';

class RegisterStore = RegisterStoreBase with _$RegisterStore;

abstract class RegisterStoreBase with Store {
  @observable
  bool isLoading = false;

  @observable
  String? error;

  @observable
  bool showPassword = false;

  @action
  void toggleShowPassword() => showPassword = !showPassword;

  @action
  Future<bool> createAccount(String email, String pass) async {
    try {
      error = null;
      isLoading = true;

      final service = AuthService(GetIt.I.get());
      await service.createAccount(
        AuthDto(email: email, pass: pass),
      );
      return true;
    } on CustomError catch (e) {
      error = e.message;
      return false;
    } finally {
      isLoading = false;
    }
  }
}
