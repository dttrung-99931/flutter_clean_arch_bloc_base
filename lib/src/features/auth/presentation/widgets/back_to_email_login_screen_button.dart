import 'package:easy_localization/easy_localization.dart';
import 'package:base_project/core/utils/evm_colors.dart';
import 'package:base_project/global.dart';
import 'package:base_project/src/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BackToEmailLoginScreenButton extends StatelessWidget {
  const BackToEmailLoginScreenButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Global.navigator.popUntil((route) => !Global.navigator.canPop());
      },
      child: Text(
        tr('auth.back_to_login_screen'),
        style: textTheme.bodyMedium?.copyWith(color: EVMColors.primary),
      ),
    );
  }
}
