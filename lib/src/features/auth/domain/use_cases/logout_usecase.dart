import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:maingames_flutter_test/core/failures/failures.dart';
import 'package:maingames_flutter_test/core/use_case/use_case.dart';
import 'package:maingames_flutter_test/core/utils/error_handlers.dart';
import 'package:maingames_flutter_test/core/utils/storage.dart';
import 'package:maingames_flutter_test/global.dart';

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
