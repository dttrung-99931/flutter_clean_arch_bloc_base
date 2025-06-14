// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/src/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_base_app/core/base_bloc/base_bloc.dart';
import 'package:flutter_base_app/core/base_bloc/base_event.dart';
import 'package:flutter_base_app/core/base_bloc/base_state.dart';
import 'package:flutter_base_app/core/utils/storage.dart';
import 'package:flutter_base_app/config/global.dart';
import 'package:flutter_base_app/shared/enums/app_mode.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends BaseBloc {
  HomeBloc(this._storage) : super(InitialState()) {
    on<OnGetAppMode>(_onGetAppMode);
    on<OnChangeAppMode>(_onChangeAppMode);
    on<OnClearSavedAppMode>(_onClaerSavedAppMode);
  }
  final Storage _storage;

  FutureOr<void> _onGetAppMode(OnGetAppMode event, Emitter<BaseState> emit) async {
    Global.appMode = _storage.appMode;
    emit(GetAppModeSuccess(_storage.appMode));
  }

  FutureOr<void> _onChangeAppMode(OnChangeAppMode event, Emitter<BaseState> emit) async {
    Global.appMode = event.mode;
    // Renew change notifier to make sure that page index will be reset to 0 on new app mode
    Global.mainPageIndexNotifier.dispose();
    Global.mainPageIndexNotifier = ValueNotifier(0);
    await _storage.saveAppMode(event.mode);
    emit(ChangeAppModeSuccess(event.mode));
  }

  FutureOr<void> _onClaerSavedAppMode(OnClearSavedAppMode event, Emitter<BaseState> emit) async {
    Global.appMode = AppMode.user; // set back to default
    await _storage.deleteAppMode();
  }
}
