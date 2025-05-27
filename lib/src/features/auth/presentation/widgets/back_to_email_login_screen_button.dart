import 'package:easy_localization/easy_localization.dart';
import 'package:maingames_flutter_test/core/utils/evm_colors.dart';
import 'package:maingames_flutter_test/global.dart';
import 'package:maingames_flutter_test/src/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BackToEmailLoginScreenButton extends StatelessWidget {
  const BackToEmailLoginScreenButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Global.navigator.popUntil((route) => !Global.navigator.canPop());
      },
      child: Text(tr('auth.back_to_login_screen'), style: textTheme.bodyMedium?.copyWith(color: EVMColors.primary)),
    );
  }
}
