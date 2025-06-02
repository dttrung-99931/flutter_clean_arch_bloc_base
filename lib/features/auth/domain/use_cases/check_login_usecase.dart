import 'dart:developer';

import 'package:maingames_flutter_test/core/use_cases/use_case.dart';
import 'package:maingames_flutter_test/core/utils/storage.dart';
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
