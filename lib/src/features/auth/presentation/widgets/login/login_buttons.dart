// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maingames_flutter_test/core/base_bloc/base_state.dart';
import 'package:maingames_flutter_test/core/utils/app_colors.dart';
import 'package:maingames_flutter_test/core/utils/extensions/ui_extensions.dart';
import 'package:maingames_flutter_test/core/utils/overlay_utils.dart';
import 'package:maingames_flutter_test/global.dart';
import 'package:maingames_flutter_test/src/config/theme/app_theme.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:maingames_flutter_test/src/features/payment/presentation/screens/payment_screen.dart';
import 'package:maingames_flutter_test/src/shared/widgets/custom_bloc_consumer.dart';
import 'package:maingames_flutter_test/src/shared/widgets/cutstom_button.dart';

class LoginButtons extends StatelessWidget {
  const LoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _LoginButton(),
        _ForgotPasswordButton(),
        _SignUpButton(),
      ],
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text('login.signUp'.tr(), style: textTheme.titleSmall.withColor(AppColors.primary)),
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  const _ForgotPasswordButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: commingSoon,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
        minimumSize: Size.zero,
      ),
      child: Text(
        'login.forgotPassword'.tr(),
        style: textTheme.bodyLarge.withColor(AppColors.primary.shade300),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return CustomBlocConsumer<LoginBloc>(
      handleLoading: false,
      buildForStates: const [LoginSuccess, LoginFailed, ErrorState, LoadingState],
      listenForStates: const [LoginSuccess],
      listener: (state) {
        if (state is LoginSuccess) {
          onLoginSuccess();
        }
      },
      builder: (state) {
        return CustomButton(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 2.w),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          onPressed: () {
            context.read<LoginBloc>().add(OnLogin());
          },
          title: 'login.loginButton'.tr(),
          elevation: 0,
          isLoading: state is LoadingState,
        );
      },
    );
  }
}

Future<Object?> onLoginSuccess() => Global.popAllAndPushNamed(PaymentScreen.route);
