import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maingames_flutter_test/core/base_bloc/base_state.dart';
import 'package:maingames_flutter_test/core/failures/failures.dart';
import 'package:maingames_flutter_test/core/utils/storage.dart';
import 'package:maingames_flutter_test/src/config/di/injection.dart';
import 'package:maingames_flutter_test/src/features/auth/domain/entities/response/login_response.dart';
import 'package:maingames_flutter_test/src/features/auth/domain/use_cases/login_usecase.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import '../../../common/base_setup.dart';
import 'login_bloc_test.mocks.dart';

@GenerateMocks([EmailLoginUseCase])
void main() {
  late MockEmailLoginUseCase mockLoginUseCase;

  setUpAll(() async {
    await baseTestSetup();
    getIt.registerTestDependecy<EmailLoginUseCase>(MockEmailLoginUseCase());
    mockLoginUseCase = getIt<EmailLoginUseCase>() as MockEmailLoginUseCase;
  });

  tearDown(() {
    getIt<Storage>().deleteAll();
  });

  tearDownAll(() {
    getIt.reset();
  });

  group('Test auth bloc', () {
    blocTest<LoginBloc, BaseState>(
      'Should emit correct state when login success',
      build: () {
        return getIt();
      },
      setUp: () {
        when(mockLoginUseCase.call(any)).thenAnswer(
          (_) async => Right(LoginResponse(token: 'accessToken')),
        );
      },
      act: (LoginBloc bloc) {
        bloc.add(OnLogin(
          email: 'test@gmail.com',
          password: 'aa123456',
        ));
      },
      expect: () => [
        LoadingState(),
        LoginSuccess(),
      ],
      verify: (bloc) {
        bloc.close();
      },
    );

    final serverError = ServerError(msg: 'Login failed', statusCode: 401);
    blocTest<LoginBloc, BaseState>(
      'Should emit correct state when login failed',
      build: () {
        return getIt();
      },
      setUp: () {
        when(mockLoginUseCase.call(any)).thenAnswer(
          (_) async {
            return Left(serverError);
          },
        );
      },
      act: (LoginBloc bloc) {
        bloc.add(OnLogin(
          email: 'test@gmail.com',
          password: 'aa123456',
        ));
      },
      expect: () => [
        LoadingState(),
        LoginFailed(serverError),
      ],
      verify: (bloc) {
        bloc.close();
      },
    );

    final networkFailure = NetworkFailure();
    blocTest<LoginBloc, BaseState>(
      'Should emit correct state when login network error',
      build: () {
        return getIt();
      },
      setUp: () {
        when(mockLoginUseCase.call(any)).thenAnswer(
          (_) async {
            return Left(networkFailure);
          },
        );
      },
      act: (LoginBloc bloc) {
        bloc.add(OnLogin(
          email: 'test@gmail.com',
          password: 'aa123456',
        ));
      },
      expect: () => [
        LoadingState(),
        LoginFailed(networkFailure),
      ],
      verify: (bloc) {
        bloc.close();
      },
    );
  });
}
