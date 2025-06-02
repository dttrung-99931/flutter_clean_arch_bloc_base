// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

class OnLogin extends BaseEvent {
  final String email;
  final String password;

  OnLogin({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class OnCheckLogin extends BaseEventWithoutProps {}

class OnRememberEmailChanged extends BaseEvent {
  final bool isRemembered;

  OnRememberEmailChanged({required this.isRemembered});

  @override
  List<Object?> get props => [isRemembered];
}

class OnDoCheckLogin extends BaseEvent {
  final void Function()? onNotLogin;
  final void Function()? onDidLogin;
  OnDoCheckLogin({
    this.onNotLogin,
    this.onDidLogin,
  });

  @override
  List<Object?> get props => [onNotLogin, onDidLogin];
}

class OnGetRememberLoginEmail extends BaseEventWithoutProps {}

class OnLogout extends BaseEventWithoutProps {}
