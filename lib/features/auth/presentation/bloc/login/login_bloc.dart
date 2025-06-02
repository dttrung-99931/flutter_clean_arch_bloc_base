// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/src/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:maingames_flutter_test/core/base_bloc/base_bloc.dart';
import 'package:maingames_flutter_test/core/base_bloc/base_event.dart';
import 'package:maingames_flutter_test/core/base_bloc/base_state.dart';
import 'package:maingames_flutter_test/core/use_cases/use_case.dart';
import 'package:maingames_flutter_test/config/global.dart';
import 'package:maingames_flutter_test/features/auth/domain/entities/request/login_request.dart';
import 'package:maingames_flutter_test/features/auth/domain/entities/response/login_response.dart';
import 'package:maingames_flutter_test/features/auth/domain/use_cases/login_usecase.dart';
import 'package:maingames_flutter_test/features/auth/domain/use_cases/logout_usecase.dart';

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
    on<OnRememberEmailChanged>(_onRememberEmailChanged);
  }

  final EmailLoginUseCase _login;
  final LogoutUseCase _logout;
  final CheckLoginUseCase _checkLoginUseCase;
  final GetRememberLoginEmailUserCase _getRememberLoginEmailUserCase;

  bool _isEmailRemembered = false;

  Future<void> _onLogin(OnLogin event, Emitter<BaseState> emit) async {
    await handleUsecaseResult(
      usecaseResult: _login.call(
        LoginParams(
          request: LoginRequest(
            email: event.email,
            password: event.password,
          ),
          rememberEmail: _isEmailRemembered,
        ),
      ),
      emit: emit.call,
      onSuccess: (LoginResponse result) {
        Global.mainPageIndexNotifier = ValueNotifier(0);
        return LoginSuccess();
      },
      onError: (failure) {
        return LoginFailed(failure);
      },
    );
  }

  Future<void> _onRememberEmailChanged(OnRememberEmailChanged event, Emitter<BaseState> emit) async {
    emit(RememberEmailCheckChanged(event.isRemembered));
    _isEmailRemembered = event.isRemembered;
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
        emit(RememberEmailCheckChanged(rememberEmail != null));
        _isEmailRemembered = rememberEmail != null;
        return GetRememberLoginEmailSuccess(rememberEmail);
      },
    );
  }

  FutureOr<void> _onDoCheckLogin(OnDoCheckLogin event, Emitter<BaseState> emit) async {
    bool isLoggedIn = _checkLoginUseCase.call(NoParams());
    isLoggedIn ? event.onDidLogin?.call() : event.onNotLogin?.call();
  }
}
