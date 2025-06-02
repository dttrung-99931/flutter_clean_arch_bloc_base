import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_base_app/core/failures/failures.dart';
import 'package:flutter_base_app/core/use_cases/use_case.dart';
import 'package:flutter_base_app/core/utils/error_handlers.dart';
import 'package:flutter_base_app/core/utils/storage.dart';
import 'package:flutter_base_app/config/global.dart';

@lazySingleton
class LogoutUseCase extends EitherUseCase<void, NoParams> {
  final Storage _storage;

  LogoutUseCase(this._storage);

  @override
  Future<Either<Failure, void>> call(NoParams param) async {
    return executeWithTryCatch(() async {
      await _storage.deleteAll();
      Global.mainPageIndexNotifier.value = 0;
    });
  }
}
