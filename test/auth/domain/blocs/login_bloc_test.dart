import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maingames_flutter_test/core/base_bloc/base_state.dart';
import 'package:maingames_flutter_test/core/failures/failures.dart';
import 'package:maingames_flutter_test/core/utils/storage.dart';
import 'package:maingames_flutter_test/src/config/di/injection.dart';
import 'package:maingames_flutter_test/src/features/auth/domain/models/login_response_model.dart';
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
  late LoginBloc loginBloc;

  setUpAll(() async {
    await baseTestSetup();
    getIt.registerTestDependecy<EmailLoginUseCase>(MockEmailLoginUseCase());
    mockLoginUseCase = getIt<EmailLoginUseCase>() as MockEmailLoginUseCase;
    loginBloc = getIt();
  });

  tearDown(() {
    getIt<Storage>().deleteAll();
  });

  tearDownAll(() {
    getIt.reset();
  });

  group('Test auth bloc', () {
    blocTest<LoginBloc, BaseState>(
      'Test login success',
      build: () {
        return loginBloc;
      },
      setUp: () {
        when(mockLoginUseCase.call(any)).thenAnswer(
          (_) async => Right(LoginResponseModel(accessToken: 'accessToken')),
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
    );

    final serverError = ServerError(msg: 'Login failed', statusCode: 401);
    blocTest<LoginBloc, BaseState>(
      'Test login failed',
      build: () {
        return loginBloc;
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
    );

    final networkFailure = NetworkFailure();
    blocTest<LoginBloc, BaseState>(
      'Test login network error',
      build: () {
        return loginBloc;
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
    );
  });
}
