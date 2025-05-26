import 'package:dartz/dartz.dart';
import 'package:base_project/core/failures/failures.dart';
import 'package:base_project/core/use_case/use_case.dart';
import 'package:base_project/core/utils/error_handlers.dart';
import 'package:base_project/core/utils/storage.dart';
import 'package:base_project/global.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LogoutUseCase extends EitherUseCase<void, NoParams> {
  final Storage _storage;

  LogoutUseCase(this._storage);

  @override
  Future<Either<Failure, void>> call(NoParams param) async {
    return executeWithTryCatch(() async {
      await _storage.deleteAll();
      Global.mainPageIndexNotifier = ValueNotifier(0);
    });
  }
}
