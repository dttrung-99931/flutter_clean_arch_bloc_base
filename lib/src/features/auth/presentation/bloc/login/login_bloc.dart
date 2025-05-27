// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/src/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:maingames_flutter_test/core/base_bloc/base_bloc.dart';
import 'package:maingames_flutter_test/core/base_bloc/base_event.dart';
import 'package:maingames_flutter_test/core/base_bloc/base_state.dart';
import 'package:maingames_flutter_test/core/use_case/use_case.dart';
import 'package:maingames_flutter_test/global.dart';
import 'package:maingames_flutter_test/src/config/app_config.dart';
import 'package:maingames_flutter_test/src/features/auth/domain/models/login_response_model.dart';
import 'package:maingames_flutter_test/src/features/auth/domain/use_cases/login_usecase.dart';
import 'package:maingames_flutter_test/src/features/auth/domain/use_cases/logout_usecase.dart';

import '../../../data/dtos/request/login_request_dto.dart';
import '../../../domain/use_cases/check_login_usecase.dart';
import '../../../domain/use_cases/get_remember_login_email_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends BaseBloc {
  LoginBloc(
    this._login,
    this._logout,
    this._checkLoginUseCase,
    this._getRememberLoginEmailUserCase,
  ) : super(InitialState()) {
    onLoad<OnLogin>(_onLogin);
    on<OnLogout>(_onLogout);
    on<OnCheckLogin>(_onCheckLogin);
    on<OnDoCheckLogin>(_onDoCheckLogin);
    on<OnGetRememberLoginEmail>(_onGetRememberLoginEmail);
  }

  final EmailLoginUseCase _login;
  final LogoutUseCase _logout;
  final CheckLoginUseCase _checkLoginUseCase;
  final GetRememberLoginEmailUserCase _getRememberLoginEmailUserCase;

  final emailEdtController = TextEditingController(
    text: AppConfig.config.isDevelopmentDebug ? 'test@maingames.com' : null,
  );
  final passwordEdtController = TextEditingController(
    text: AppConfig.config.isDevelopmentDebug ? 'aa123456' : null,
  );
  final rememberPhoneController = ValueNotifier<bool>(false);

  Future<void> _onLogin(OnLogin event, Emitter<BaseState> emit) async {
    await handleUsecaseResult(
      usecaseResult: _login.call(
        LoginParams(
          requestModel: LoginRequestDto(
            email: emailEdtController.text,
            password: passwordEdtController.text,
          ),
          rememberEmail: rememberPhoneController.value,
        ),
      ),
      emit: emit.call,
      onSuccess: (LoginResponseModel result) {
        Global.mainPageIndexNotifier = ValueNotifier(0);
        return LoginSuccess();
      },
      onError: (failure) {
        return LoginFailed(failure);
      },
    );
  }

  Future<void> _onLogout(OnLogout event, Emitter<BaseState> emit) async {
    await handleUsecaseResult(
      usecaseResult: _logout.call(noParam),
      emit: emit.call,
      onSuccess: (result) {
        add(OnCheckLogin());
        return LogoutSuccess();
      },
    );
  }

  Future<void> _onCheckLogin(OnCheckLogin event, Emitter<BaseState> emit) async {
    bool isLoggedIn = _checkLoginUseCase.call(NoParams());
    emit(CheckLoginSuccess(isLoggedIn));
  }

  Future<void> _onGetRememberLoginEmail(OnGetRememberLoginEmail event, Emitter<BaseState> emit) async {
    await handleUsecaseResult(
      usecaseResult: _getRememberLoginEmailUserCase.call(noParam),
      emit: emit.call,
      onSuccess: (String? rememberEmail) {
        return GetRememberLoginEmailSuccess(rememberEmail);
      },
    );
  }

  FutureOr<void> _onDoCheckLogin(OnDoCheckLogin event, Emitter<BaseState> emit) async {
    bool isLoggedIn = _checkLoginUseCase.call(NoParams());
    isLoggedIn ? event.onDidLogin?.call() : event.onNotLogin?.call();
  }

  @override
  Future<void> close() async {
    emailEdtController.dispose();
    passwordEdtController.dispose();
    rememberPhoneController.dispose();
    await super.close();
  }
}
