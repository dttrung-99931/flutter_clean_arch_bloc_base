import 'dart:developer';

import 'package:base_project/core/use_case/use_case.dart';
import 'package:base_project/core/utils/storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckLoginUseCase extends UseCase<bool, NoParams> {
  final Storage _storage;

  CheckLoginUseCase(this._storage);

  @override
  bool call(NoParams param) {
    log('TOKEN: Bearer ${_storage.token}');
    return _storage.token != null;
  }
}
