import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/failures/failures.dart';
import 'package:flutter_base_app/core/use_cases/use_case.dart';
import 'package:flutter_base_app/core/utils/error_handlers.dart';
import 'package:flutter_base_app/core/utils/storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetRememberLoginEmailUserCase extends EitherUseCase<String?, NoParams> {
  final Storage _storage;

  GetRememberLoginEmailUserCase(this._storage);

  @override
  Future<Either<Failure, String?>> call(NoParams param) async {
    return executeWithTryCatch(() async {
      return _storage.loginEmail;
    });
  }
}
