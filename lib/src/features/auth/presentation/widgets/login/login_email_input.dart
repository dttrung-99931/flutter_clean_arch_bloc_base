// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maingames_flutter_test/core/utils/validate.dart';
import 'package:maingames_flutter_test/src/shared/widgets/text_input.dart';

class LoginEmailInput extends StatelessWidget {
  final TextEditingController controller;

  const LoginEmailInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextInput(
      hintText: 'login.emailHint'.tr(),
      controller: controller,
      textInputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: Validate.email,
    );
  }
}
