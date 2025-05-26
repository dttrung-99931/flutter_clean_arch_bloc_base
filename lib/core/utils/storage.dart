// ignore_for_file: constant_identifier_names

import 'package:evievm_app/core/utils/extensions/list_extension.dart';
import 'package:evievm_app/src/features/main/presentation/blocs/main/main_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const KEY_TOKEN = '_KEY_TOKEN';
const KEY_USER_PROFILE = '_KEY_USER_PROFILE';
const KEY_LOGIN_EMAIL = '_KEY_LOGIN_EMAIL';
const KEY_APP_MODE = '_KEY_APP_MODE';

abstract class LocalStorage {
  Future<void> init();
  String? getString(String key);
  Future<bool> setString(String key, String value);
  Future<bool> remove(String key);
}

@LazySingleton(as: LocalStorage)
class SharePrefLocalStorage extends LocalStorage {
  late final SharedPreferences _preferences;
  @override
  String? getString(String key) {
    return _preferences.getString(key);
  }

  @override
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> remove(String key) {
    return _preferences.remove(key);
  }

  @override
  Future<bool> setString(String key, String value) {
    return _preferences.setString(key, value);
  }
}

class Storage {
  final LocalStorage _storage;

  Storage(this._storage);

  Future<Storage> init() async {
    await _storage.init();
    return this;
  }

  Future<void> deleteAll() async {
    deleteToken();
    deleteAppMode();
  }
}

extension TokenStrorage on Storage {
  Future<void> saveToken(String value) async {
    await _storage.setString(KEY_TOKEN, value);
  }

  Future<void> deleteToken() async {
    await _storage.remove(KEY_TOKEN);
  }

  String? get token => _storage.getString(KEY_TOKEN);
}

extension LoginEmailStrorage on Storage {
  Future<void> saveLoginEmail(String value) async {
    await _storage.setString(KEY_LOGIN_EMAIL, value);
  }

  Future<void> deleteLoginEmail() async {
    await _storage.remove(KEY_LOGIN_EMAIL);
  }

  String? get loginEmail => _storage.getString(KEY_LOGIN_EMAIL);
}

extension AppModeStrorage on Storage {
  Future<void> saveAppMode(AppMode value) async {
    await _storage.setString(KEY_APP_MODE, value.name);
  }

  Future<void> deleteAppMode() async {
    await _storage.remove(KEY_APP_MODE);
  }

  AppMode get appMode {
    return AppMode.values.firstWhereOrNull(
          (p0) => p0.name == _storage.getString(KEY_APP_MODE),
        ) ??
        AppMode.user;
  }
}
