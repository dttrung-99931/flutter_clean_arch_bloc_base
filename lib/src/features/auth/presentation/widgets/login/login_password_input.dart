// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:maingames_flutter_test/src/shared/widgets/text_input.dart';

class LoginPasswordInput extends StatelessWidget {
  const LoginPasswordInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextInput(
      hintText: 'login.passwordHint'.tr(),
      controller: context.read<LoginBloc>().passwordEdtController,
      isPasswordInput: true,
      textInputAction: TextInputAction.done,
      onSubmited: (_) {
        context.read<LoginBloc>().add(OnLogin());
      },
    );
  }
}
