// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_base_app/config/app_router.dart';
import 'package:flutter_base_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_base_app/shared/widgets/common/unregister_widget.dart';

class NotLoginWidget extends StatelessWidget {
  const NotLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return UnregisterWidget(
      title: 'Bạn chưa đăng nhập!',
      buttonTitle: 'Đăng nhập',
      onPressed: () {
        AppRouter.pushNamed(LoginScreen.route);
      },
    );
  }
}
