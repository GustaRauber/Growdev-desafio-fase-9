import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/utils/constants.dart';

part 'splash.store.g.dart';

class SplashStore = SplashStoreBase with _$SplashStore;

abstract class SplashStoreBase with Store {
  Future<bool> userIsAuthenticated() async {
    final sharedPref = await SharedPreferences.getInstance();

    final token = sharedPref.getString("token_user");
    if (token == null) return false;
    Constants.userToken = token;
    return true;
  }
}
