import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/failures/failures.dart';

extension FutureExt on Future {
  Future<T2> thenMap<T1, T2>(
    T2 Function(T1 value) mapper, {
    void Function(Object? failure)? onError,
  }) {
    return then((value) => mapper(value), onError: (e) {
      onError?.call(e);
    });
  }
}

extension FutureEitherExt<T> on Future<Either<Failure, T>> {
  Future<Either<Failure, T2>> thenMap<T2>(
    T2 Function(T value) mapper, {
    void Function(Object? failure)? onError,
  }) {
    return then((Either<Failure, T> value) => value.map(mapper), onError: (e) {
      onError?.call(e);
    });
  }
}
