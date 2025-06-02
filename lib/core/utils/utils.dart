import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_app/config/app_router.dart';
import 'package:flutter_base_app/config/global.dart';
import 'package:flutter_base_app/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_base_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

final emptyConditions = ['', 0, []];
bool isNullOrEmpty(dynamic obj) {
  return obj == null || emptyConditions.contains(obj);
}

removeCurrentFocus() async {
  if (Global.overlayEntries.isNotEmpty) {
    Global.overlayEntries.removeLast().remove();
  }
  FocusManager.instance.primaryFocus?.unfocus();
}

Future delay(Duration duration) async {
  await Future.delayed(duration);
}

bool isNumeric(String str) {
  try {
    double.parse(str);
    return true;
  } catch (e) {
    return false;
  }
}

Future delayMilis(int milliseconds) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}

Color? hexToColor(String? code) {
  if (code == null) return null;
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

void doOnBuildUICompleted(void Function() action) {
  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    action();
  });
}

void doIfLoggedIn(void Function() onDidLogin, {bool navToLoginIfNot = false}) {
  Global.context.read<LoginBloc>().add(
        OnDoCheckLogin(
          onDidLogin: onDidLogin,
          onNotLogin: () {
            if (navToLoginIfNot) {
              AppRouter.pushNamed(LoginScreen.route);
            }
          },
        ),
      );
}

bool isSubtype<S, T>() => <S>[] is List<T>;

class Utils {
  static int getTotalPages(int total, int pageSize) {
    return total ~/ pageSize + (total % pageSize == 0 ? 0 : 1);
  }
}
