// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maingames_flutter_test/core/utils/app_colors.dart';
import 'package:maingames_flutter_test/core/utils/evm_colors.dart';
import 'package:maingames_flutter_test/core/utils/extensions/num_extensions.dart';
import 'package:maingames_flutter_test/core/utils/extensions/ui_extensions.dart';
import 'package:maingames_flutter_test/src/config/di/injection.dart';
import 'package:maingames_flutter_test/src/config/theme/app_theme.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/widgets/login/login_background.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/widgets/login/login_buttons.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/widgets/login/login_email_input.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/widgets/login/login_password_input.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/widgets/login/remember_email_check_box.dart';

class LoginScreen extends StatelessWidget {
  static const route = '/login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EVMColors.white,
      body: Stack(
        children: [
          const LoginBackground(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: .15.sw),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'login.appTitle'.tr(),
                        style: textTheme.titleLarge
                            .withColor(context.isKeyboardShowing ? AppColors.black : AppColors.primary)
                            .withSize(40.sp),
                      ),
                      52.shb,
                      const LoginEmailInput(),
                      16.shb,
                      const LoginPasswordInput(),
                      6.shb,
                      const RememberEmailCheckBox(),
                      4.shb,
                      const LoginButtons(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
