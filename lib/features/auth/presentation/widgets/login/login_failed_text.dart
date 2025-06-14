// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/utils/evm_colors.dart';
import 'package:flutter_base_app/core/utils/extensions/num_extensions.dart';
import 'package:flutter_base_app/config/theme/app_theme.dart';
import 'package:flutter_base_app/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_base_app/shared/widgets/custom_bloc_builder.dart';

class LoginFailedText extends StatelessWidget {
  const LoginFailedText({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBlocBuilder<LoginBloc>(
      // Listen GetRememberLoginEmailSuccess to clear error message if there's error from scanner login screen
      buildForStates: const [LoginFailed, GetRememberLoginEmailSuccess],
      handleLoading: false,
      builder: (state) {
        return AnimatedSize(
          duration: 300.milliseconds,
          child: state is LoginFailed
              ? Text(state.failure.displayMsg, style: textTheme.bodyMedium!.copyWith(color: EVMColors.red))
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
