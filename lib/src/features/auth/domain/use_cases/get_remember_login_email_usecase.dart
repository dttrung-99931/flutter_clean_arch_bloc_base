import 'package:dartz/dartz.dart';
import 'package:base_project/core/failures/failures.dart';
import 'package:base_project/core/use_case/use_case.dart';
import 'package:base_project/core/utils/error_handlers.dart';
import 'package:base_project/core/utils/storage.dart';
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
