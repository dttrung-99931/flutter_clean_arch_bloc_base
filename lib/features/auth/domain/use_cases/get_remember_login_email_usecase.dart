import 'package:dartz/dartz.dart';
import 'package:maingames_flutter_test/core/failures/failures.dart';
import 'package:maingames_flutter_test/core/use_cases/use_case.dart';
import 'package:maingames_flutter_test/core/utils/error_handlers.dart';
import 'package:maingames_flutter_test/core/utils/storage.dart';
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
