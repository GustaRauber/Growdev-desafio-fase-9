import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/errors/custom_error.model.dart';
import '../../../../shared/utils/constants.dart';
import '../../dtos/auth.dto.dart';
import '../../services/auth.service.dart';

part 'login.store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  @observable
  bool isLoading = false;

  @observable
  String? error;

  @observable
  bool showPassword = false;

  @action
  void toggleShowPassword() => showPassword = !showPassword;

  @action
  Future<bool> login(String email, String pass) async {
    try {
      error = null;
      isLoading = true;

      final service = AuthService(GetIt.I.get());
      final tokenUser = await service.login(
        AuthDto(email: email, pass: pass),
      );

      Constants.userToken = tokenUser;

      final sharedPreferences = await SharedPreferences.getInstance();

      sharedPreferences.setString('token_user', tokenUser);

      return true;
    } on CustomError catch (e) {
      error = e.message;
      return false;
    } finally {
      isLoading = false;
    }
  }
}
