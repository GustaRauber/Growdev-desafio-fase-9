// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterStore on RegisterStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'RegisterStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorAtom =
      Atom(name: 'RegisterStoreBase.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$showPasswordAtom =
      Atom(name: 'RegisterStoreBase.showPassword', context: context);

  @override
  bool get showPassword {
    _$showPasswordAtom.reportRead();
    return super.showPassword;
  }

  @override
  set showPassword(bool value) {
    _$showPasswordAtom.reportWrite(value, super.showPassword, () {
      super.showPassword = value;
    });
  }

  late final _$createAccountAsyncAction =
      AsyncAction('RegisterStoreBase.createAccount', context: context);

  @override
  Future<bool> createAccount(String email, String pass) {
    return _$createAccountAsyncAction
        .run(() => super.createAccount(email, pass));
  }

  late final _$RegisterStoreBaseActionController =
      ActionController(name: 'RegisterStoreBase', context: context);

  @override
  void toggleShowPassword() {
    final _$actionInfo = _$RegisterStoreBaseActionController.startAction(
        name: 'RegisterStoreBase.toggleShowPassword');
    try {
      return super.toggleShowPassword();
    } finally {
      _$RegisterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
error: ${error},
showPassword: ${showPassword}
    ''';
  }
}
