// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maingames_flutter_test/core/utils/validate.dart';
import 'package:maingames_flutter_test/src/shared/widgets/text_input.dart';

class LoginPasswordInput extends StatelessWidget {
  const LoginPasswordInput({
    super.key,
    required this.controller,
    required this.onSubmited,
  });

  final TextEditingController controller;
  final Function(String? text) onSubmited;

  @override
  Widget build(BuildContext context) {
    return TextInput(
      hintText: 'login.passwordHint'.tr(),
      controller: controller,
      isPasswordInput: true,
      textInputAction: TextInputAction.done,
      onSubmited: onSubmited,
      validator: (text) {
        return Validate.validateRequired(text!, fieldName: 'password');
      },
    );
  }
}
