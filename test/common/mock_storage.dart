import 'package:maingames_flutter_test/core/utils/storage.dart';

const _TEST_USER_TOKEN =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMTIiLCJjYXJ0X2lkIjoiOSIsInN1YiI6IjA5ODgyMDIwNzEiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJ1c2VyIiwiZXhwIjoxNzEwOTIzMjkxLCJpc3MiOiJEVFQiLCJhdWQiOiJEVFQifQ.FI_TEWuQ-MgMFGs6jZ42j1fI2dPFRqzSZE_iCxQIMkk';

class MockLocalStorage extends LocalStorage {
  final _data = {KEY_TOKEN: _TEST_USER_TOKEN, KEY_LOGIN_EMAIL: 'test1@gmail.com', KEY_APP_MODE: 'user'};
  @override
  String? getString(String key) {
    return _data[key];
  }

  @override
  Future<void> init() async {}

  @override
  Future<bool> remove(String key) async {
    _data.remove(key);
    return true;
  }

  @override
  Future<bool> setString(String key, String value) async {
    _data[key] = value;
    return true;
  }
}
