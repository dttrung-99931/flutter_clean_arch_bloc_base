// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maingames_flutter_test/core/utils/app_colors.dart';
import 'package:maingames_flutter_test/core/utils/extensions/ui_extensions.dart';
import 'package:maingames_flutter_test/core/utils/overlay_utils.dart';
import 'package:maingames_flutter_test/src/config/theme/app_theme.dart';
import 'package:maingames_flutter_test/src/shared/widgets/cutstom_button.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text('login.signUp'.tr(), style: textTheme.titleSmall.withColor(AppColors.primary)),
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

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

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.onPressed, required this.isLoading});
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 2.w),
      padding: EdgeInsets.symmetric(vertical: 12.h),
      onPressed: onPressed,
      title: 'login.loginButton'.tr(),
      elevation: 0,
      isLoading: isLoading,
    );
  }
}
