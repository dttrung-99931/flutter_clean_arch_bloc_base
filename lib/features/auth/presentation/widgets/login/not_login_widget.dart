// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:maingames_flutter_test/config/app_router.dart';
import 'package:maingames_flutter_test/features/auth/presentation/screens/login_screen.dart';
import 'package:maingames_flutter_test/shared/widgets/common/unregister_widget.dart';

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
