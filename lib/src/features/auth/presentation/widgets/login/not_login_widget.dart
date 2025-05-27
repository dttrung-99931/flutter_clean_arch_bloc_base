// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:maingames_flutter_test/global.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/screens/login_screen.dart';
import 'package:maingames_flutter_test/src/shared/widgets/common/unregister_widget.dart';
import 'package:flutter/material.dart';

class NotLoginWidget extends StatelessWidget {
  const NotLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return UnregisterWidget(
      title: 'Bạn chưa đăng nhập!',
      buttonTitle: 'Đăng nhập',
      onPressed: () {
        Global.pushNamed(LoginScreen.route);
      },
    );
  }
}
